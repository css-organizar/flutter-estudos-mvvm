import 'package:flutter_estudos_mvvm/infrastructure/dal/sembast/dao/sembast_dao.dart';
import 'package:flutter_estudos_mvvm/infrastructure/dal/sembast/entities/sembast_pessoa_entity.dart';

class SembastPessoaDao extends SembastDao<SembastPessoaEntity> {
  @override
  String get storeName => 'pessoa';
  @override
  StoreRef get store => intMapStoreFactory.store(storeName);

  @override
  Future<List<SembastPessoaEntity>?> getAll() async {
    final recordSnapshot = await super.getAll();

    return recordSnapshot!.map(
      (snapshot) {
        final pessoa = SembastPessoaEntity.fromMap(
          snapshot.value,
        );
        return pessoa;
      },
    ).toList();
  }

  Future<SembastPessoaEntity?> getById(int value) async {
    SembastPessoaEntity? returnPessoaEntity;

    final recordSnapshot = await super.getByField('id', value);

    if (recordSnapshot[0] != null) {
      returnPessoaEntity = SembastPessoaEntity.fromMap(
        recordSnapshot[0].value,
      );
    }

    return returnPessoaEntity;
  }

  Future<SembastPessoaEntity?> getByName(String value) async {
    SembastPessoaEntity? returnPessoaEntity;

    final recordSnapshot = await super.getByField('nome', value);

    if (recordSnapshot[0] != null) {
      returnPessoaEntity = SembastPessoaEntity.fromMap(
        recordSnapshot[0].value,
      );
    }

    return returnPessoaEntity;
  }
}
