import 'package:drift/drift.dart';

import '../../../domain/entities/cidades.dart';
import '../app_database.dart';

Cidades toEntity(CidadesTableData data) {
  return Cidades(
    id: data.id,
    descricao: data.descricao,
  );
}

CidadesTableCompanion toCompanion(Cidades entity) {
  return CidadesTableCompanion(
    id: Value(entity.id),
    descricao: Value(entity.descricao),
  );
}
