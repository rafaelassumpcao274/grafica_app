import 'package:drift/drift.dart';
import 'package:unilith_app/features/ordemServico/data/local/tables/viacores_table.dart';
import 'package:uuid/uuid.dart';

import 'fornecedor_table.dart';
import 'ordemservico_table.dart';

class ViaCoresOrdemServicoTable extends Table {
  TextColumn get id => text().clientDefault(() =>   Uuid().v4())();

  IntColumn get ordemServicoId =>
      integer().references(OrdemServicoTable, #id)();

  TextColumn get viaCoresId =>
      text().references(ViaCoresTable, #id)();

  IntColumn get ordem => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};

}
