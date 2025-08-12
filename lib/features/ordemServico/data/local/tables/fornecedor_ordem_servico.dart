import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'fornecedor_table.dart';
import 'ordemservico_table.dart';

class FornecedorOrdemServicoTable extends Table {
  TextColumn get id => text().clientDefault(() =>   Uuid().v4())();

  IntColumn get ordemServicoId =>
      integer().references(OrdemServicoTable, #id)();

  TextColumn get fornecedorId =>
      text().references(FornecedorTable, #id)();

  RealColumn get custo => real().withDefault(const Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};

}
