import 'package:app/src/shared/models/produto.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class CarrinhoBloc extends BlocBase {
  List<Produto> _listaProdutos;

  trucateList() {
    _listaProdutos.clear();
    _produtosCarrinhoController.add([]);
  }

  final _produtosCarrinhoController = BehaviorSubject.seeded(<Produto>[]);
  Observable<List<Produto>> get produtosCarrinho =>
      _produtosCarrinhoController.stream;

  Observable<int> get totalCarrinho => _totalCarrinhoController.stream;

  final _addItemCarrinhoController = BehaviorSubject<Produto>();
  Sink<Produto> get addItemCarrinho => _addItemCarrinhoController.sink;

  final _removeItemCarrinhoController = BehaviorSubject<Produto>();
  Sink<Produto> get removeItemCarrinho => _removeItemCarrinhoController.sink;

  final _totalCarrinhoController = BehaviorSubject<int>();

  _handleAddItemCarrinho(Produto produto) {
    _listaProdutos.add(produto);
    _produtosCarrinhoController.add(_listaProdutos);
  }

  _handleRemoveItemCarrinho(Produto produto) {
    _listaProdutos.remove(produto);
    _produtosCarrinhoController.add(_listaProdutos);
  }

  CarrinhoBloc() {
    _listaProdutos = List<Produto>();
    _addItemCarrinhoController.listen(_handleAddItemCarrinho);
    _removeItemCarrinhoController.listen(_handleRemoveItemCarrinho);

    _produtosCarrinhoController
        .listen((lista) => _totalCarrinhoController.add(lista.length));
  }

  void dispose() {
    _produtosCarrinhoController.close();
    _totalCarrinhoController.close();
  }
}
