import 'package:drift/drift.dart';
import 'parcela_table.dart';
import '../config/sqlite_epoch_ms_date_time_converter.dart';

class RecebimentoTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get parcelaId => integer().references(ParcelaTable, #id)();

  RealColumn get valor => real().withDefault(const Constant(0.0))();

  IntColumn get dataPagamento => integer().map(const SqliteEpochMsDateTimeConverter())();

  TextColumn get formaPagamento => text().nullable()();
}
