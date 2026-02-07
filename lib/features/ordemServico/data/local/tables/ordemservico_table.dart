import 'package:drift/drift.dart';
import 'package:unilith_app/features/ordemServico/data/local/tables/papel_table.dart';

import '../config/sqlite_date_time_converter.dart';
import 'clientes_table.dart';
import 'formato_table.dart';

class OrdemServicoTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get clienteId => text().references(ClientesTable, #id)();

  TextColumn get formatoId => text().references(FormatoTable, #id).nullable()();

  TextColumn get papelId => text().references(PapelTable, #id).nullable()();

  TextColumn get material => text()();

  TextColumn get corFrente => text()();

  TextColumn get corVerso => text()();

  IntColumn get quantidadeFolha => integer()();

  BoolColumn get possuiNumeracao => boolean().withDefault(Constant(false))();

  IntColumn get numeracaoInicial => integer()();

  IntColumn get numeracaoFinal => integer()();

  TextColumn get observacao => text()();

  RealColumn get valorCusto => real().withDefault(Constant(0.0))();

  RealColumn get valorTotal => real().withDefault(Constant(0.0))();

  TextColumn get tamanhoImagem => text()();

  DateTimeColumn get createdAt =>
      dateTime()
      .withDefault(currentDateAndTime)();

}
