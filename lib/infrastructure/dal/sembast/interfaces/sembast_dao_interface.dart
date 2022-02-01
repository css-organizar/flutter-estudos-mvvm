abstract class ISembastDao<T> {
  Future<void> clear() async {}
  Future<void> insert(T value) async {}
  Future<void> update(T value) async {}
  Future<void> delete(T value) async {}
  Future<void> insertAll(List<T> entities) async {}
  Future<void> updateAll(List<T> entities) async {}
  Future<void> deleteAll(List<T> entities) async {}
}
