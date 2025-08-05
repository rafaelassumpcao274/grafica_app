
import 'package:drift/drift.dart';

import '../../../domain/entities/uf.dart';
import '../app_database.dart' show UfTableData, UfTableCompanion;

Uf toEntity(UfTableData data) {
  return Uf(
    id: data.id,
    descricao: data.descricao,
    sigla: data.sigla,
  );
}

UfTableCompanion toCompanion(Uf entity) {
  return UfTableCompanion(
    id: Value(entity.id),
    descricao: Value(entity.descricao),
    sigla: Value(entity.sigla),
  );
}
