

import '../../../domain/entities/viacores.dart';
import 'package:drift/drift.dart';
import '../app_database.dart';

ViaCores toEntity(ViaCoresTableData data) {
  return ViaCores(
    id: data.id,
    descricao: data.descricao,
  );
}

ViaCoresTableCompanion toCompanion(ViaCores entity) {
  return ViaCoresTableCompanion(
    id: Value(entity.id),
    descricao: Value(entity.descricao),
  );
}
