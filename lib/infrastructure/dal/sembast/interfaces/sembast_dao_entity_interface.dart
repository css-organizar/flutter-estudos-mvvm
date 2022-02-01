abstract class ISembastDaoEntity {
  int? id;
  dynamic get identifier;
  String get identifierName;

  Map<String, dynamic> toMap();
}
