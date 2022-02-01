import 'package:flutter/cupertino.dart';
import 'package:flutter_estudos_mvvm/infrastructure/dal/sembast/dao/sembast_pessoa_dao.dart';
import 'package:flutter_estudos_mvvm/infrastructure/dal/sembast/entities/sembast_pessoa_entity.dart';

class HomeViewModel extends ChangeNotifier {
  ValueNotifier<List<int>> selectedItem = ValueNotifier([]);
  ValueNotifier<List<SembastPessoaEntity>> listaPessoa = ValueNotifier([]);

  clean() async {
    await SembastPessoaDao().clear();

    getListaPessoa();
  }

  deleteAll() async {
    var itens = [
      SembastPessoaEntity(1, 'item 1', 'email', 0, 0),
      SembastPessoaEntity(2, 'item 2', 'email', 0, 0),
      SembastPessoaEntity(3, 'item 3', 'email', 0, 0),
      SembastPessoaEntity(4, 'item 4', 'email', 0, 0),
    ];

    await SembastPessoaDao().deleteAll(itens);
    getListaPessoa();
  }

  deleteById(int id) async {
    await SembastPessoaDao().deleteById(id);
    getListaPessoa();
  }

  update() async {
    var item = SembastPessoaEntity(1, 'item 1xxxx', 'email', 0, 0);

    await SembastPessoaDao().update(item);
    getListaPessoa();
  }

  updateAll() async {
    var itens = [
      SembastPessoaEntity(1, 'item 1', 'email', 0, 0),
      SembastPessoaEntity(2, 'item 22', 'email', 0, 0),
      SembastPessoaEntity(3, 'item 333', 'email', 0, 0),
      SembastPessoaEntity(4, 'item 4444', 'email', 0, 0),
    ];

    await SembastPessoaDao().updateAll(itens);
    getListaPessoa();
  }

  addPessoa() async {
    await SembastPessoaDao().insert(SembastPessoaEntity(0, DateTime.now().toIso8601String(), 'email', 0, 0));
    getListaPessoa();
  }

  addAll() async {
    var itens = [
      SembastPessoaEntity(1, 'item 1', 'email', 0, 0),
      SembastPessoaEntity(2, 'item 2', 'email', 0, 0),
      SembastPessoaEntity(3, 'item 3', 'email', 0, 0),
      SembastPessoaEntity(4, 'item 4', 'email', 0, 0),
    ];

    await SembastPessoaDao().insertAll(itens);
    getListaPessoa();
  }

  setSelectedIten(int index) {
    if (selectedItem.value.contains(index)) {
      selectedItem.value.remove(index);
    } else {
      selectedItem.value.add(index);
    }
    selectedItem.notifyListeners();
  }

  getListaPessoa() async {
    var lista = await SembastPessoaDao().getAll();
    listaPessoa.value.clear();

    if (lista != null) {
      listaPessoa.value.addAll(lista);
    }

    listaPessoa.notifyListeners();
  }

  getById() async {
    var result = await SembastPessoaDao().getByName('item 1');
    print(result!.toJson());
  }
}
