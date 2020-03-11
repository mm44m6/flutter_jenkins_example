import 'dart:convert';

import 'package:app/src/shared/interceptors/cache_inteceptor.dart';
import 'package:app/src/shared/models/produto.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralApi {
  Dio dio;
  GeneralApi(this.dio) {
    dio.interceptors.add(CacheInterceptor());
  }

  Future<List<Produto>> getProducts() async {
    try {
      Response response = await dio.get(
        //Mock api lista de produtos
        "http://localhost:8080/api/list-products",
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("Produto", response.data);
      List data = jsonDecode(response.data);
      List<Produto> produtos = data.map((v) => Produto.fromJson(v)).toList();
      return produtos;
    } on DioError catch (e) {
      throw "error internet";
    } catch (e) {
      throw "Erro desconhecido";
    }
  }
}
