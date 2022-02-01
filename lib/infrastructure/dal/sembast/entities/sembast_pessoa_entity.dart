import 'dart:convert';

import 'package:flutter_estudos_mvvm/infrastructure/dal/sembast/interfaces/sembast_dao_entity_interface.dart';

class SembastPessoaEntity implements ISembastDaoEntity {
  @override
  int? id;
  String? nome;
  String? email;
  int? idade;
  int? telefone;

  @override
  String get identifierName => 'id';
  @override
  get identifier => id;

  SembastPessoaEntity(
    this.id,
    this.nome,
    this.email,
    this.idade,
    this.telefone,
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'idade': idade,
      'telefone': telefone,
    };
  }

  factory SembastPessoaEntity.fromMap(Map<String, dynamic> map) {
    return SembastPessoaEntity(
      map['id']?.toInt(),
      map['nome'],
      map['email'],
      map['idade']?.toInt(),
      map['telefone']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SembastPessoaEntity.fromJson(String source) => SembastPessoaEntity.fromMap(json.decode(source));
}
