
import 'package:drift/drift.dart';

import '../../../domain/entities/fornecedor.dart' show Fornecedor;
import '../app_database.dart';

Fornecedor toEntity(FornecedorTableData data) {
  return Fornecedor(
    id: data.id,
    descricao: data.descricao,
    preco: data.preco,
  );
}

FornecedorTableCompanion toCompanion(Fornecedor entity) {
  return FornecedorTableCompanion(
    id: Value(entity.id),
    descricao: Value(entity.descricao),
    preco: Value(entity.preco),
  );
}
