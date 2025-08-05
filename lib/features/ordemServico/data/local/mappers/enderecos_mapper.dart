
import '../../../domain/entities/enderecos.dart';
import 'package:drift/drift.dart';

import '../app_database.dart';

Enderecos toEntity(EnderecosTableData data) {
  return Enderecos(
    id: data.id,
    logradouro: data.logradouro,
    cep: data.cep,
    complemento: data.complemento,
    numero: data.numero,
  );
}

EnderecosTableCompanion toCompanion(Enderecos entity) {
  return EnderecosTableCompanion(
    id: Value(entity.id),
    logradouro: Value(entity.logradouro),
    cep: Value(entity.cep),
    complemento: Value(entity.complemento),
    numero: Value(entity.numero),
  );
}
