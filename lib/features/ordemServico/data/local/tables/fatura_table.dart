import 'package:drift/drift.dart';
import 'package:unilith_app/features/ordemServico/data/local/tables/ordemservico_table.dart';
import '../config/sqlite_epoch_ms_date_time_converter.dart';

class FaturaTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get ordemServicoId => integer().nullable().references(OrdemServicoTable, #id)();

  TextColumn get descricao => text().nullable()();

  RealColumn get valorTotal => real().withDefault(const Constant(0.0))();

  TextColumn get status => text().withDefault(const Constant('ABERTA'))();

  IntColumn get createdAt => integer().map(const SqliteEpochMsDateTimeConverter())();
}
