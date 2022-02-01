export 'package:sembast/sembast.dart';

import 'package:flutter_estudos_mvvm/infrastructure/dal/sembast/interfaces/sembast_dao_entity_interface.dart';
import 'package:flutter_estudos_mvvm/infrastructure/dal/sembast/interfaces/sembast_dao_interface.dart';
import 'package:flutter_estudos_mvvm/infrastructure/services/sembast/sembast_connection_service.dart';
import 'package:sembast/sembast.dart';

abstract class SembastDao<T extends ISembastDaoEntity> implements ISembastDao<T> {
  String get storeName;
  StoreRef get store;

  Future<Database> get db async {
    return await SembastConnectionService.instance.database;
  }

  @override
  Future<void> clear() async {
    await store.delete(await db);
  }

  @override
  Future<void> insert(T entity) async {
    entity.id = await store.add(
      await db,
      entity.toMap(),
    );

    await update(entity);
  }

  @override
  Future<void> insertAll(List<T> entities) async {
    final maps = entities
        .map(
          (entity) => entity.toMap(),
        )
        .toList();

    await store.addAll(await db, maps);
  }

  @override
  Future<void> update(T entity) async {
    final finder = Finder(
      filter: Filter.byKey(
        entity.id,
      ),
    );

    await store.update(
      await db,
      entity.toMap(),
      finder: finder,
    );
  }

  @override
  Future<void> updateAll(List<T> entities) async {
    for (T entity in entities) {
      await update(entity);
    }
  }

  @override
  Future<void> delete(T entity) async {
    final finder = Finder(
      filter: Filter.byKey(
        entity.id,
      ),
    );

    await store.delete(
      await db,
      finder: finder,
    );
  }

  @override
  Future<void> deleteAll(List<T> entities) async {
    final finder = Finder(
      filter: Filter.or(
        entities
            .map(
              (entity) => Filter.equals(
                entity.identifierName,
                entity.id,
              ),
            )
            .toList(),
      ),
    );

    await store.delete(
      await db,
      finder: finder,
    );
  }

  Future<void> deleteByKey(int key) async {
    final finder = Finder(
      filter: Filter.byKey(key),
    );

    await store.delete(
      await db,
      finder: finder,
    );
  }

  Future<void> deleteById(int id) async {
    final finder = Finder(
      filter: Filter.equals(
        'id',
        id,
      ),
    );

    await store.delete(
      await db,
      finder: finder,
    );
  }

  Future<List<dynamic>?> getAll() async {
    final recordSnapshot = await store.find(await db);

    return recordSnapshot;
  }

  Future<dynamic> getByField(
    String field,
    dynamic value,
  ) async {
    final finder = Finder(
      filter: Filter.equals(
        field,
        value,
      ),
    );

    final recordSnapshot = await store.find(
      await db,
      finder: finder,
    );

    return recordSnapshot;
  }
}
