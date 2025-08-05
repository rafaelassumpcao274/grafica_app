
import 'package:drift/drift.dart';

import '../../../domain/entities/papel.dart';
import '../app_database.dart';

Papel toEntity(PapelTableData data) {
  return Papel(
    id: data.id,
    descricao: data.descricao,
    quantidadePapel: data.quantidadePapel,
  );
}

PapelTableCompanion toCompanion(Papel entity) {
  return PapelTableCompanion(
    id: Value(entity.id),
    descricao: Value(entity.descricao),
    quantidadePapel: Value(entity.quantidadePapel),
  );
}
