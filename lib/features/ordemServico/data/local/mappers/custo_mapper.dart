
import 'package:drift/drift.dart';

import '../../../domain/entities/custo.dart' show Custo;
import '../app_database.dart' show CustoTableData, CustoTableCompanion;

Custo toEntity(CustoTableData data) {
  return Custo(
    id: data.id,
    descricao: data.descricao,
    valor: data.valor,
  );
}

CustoTableCompanion toCompanion(Custo entity) {
  return CustoTableCompanion(
    id: Value(entity.id),
    descricao: Value(entity.descricao),
    valor: Value(entity.valor),
  );
}
