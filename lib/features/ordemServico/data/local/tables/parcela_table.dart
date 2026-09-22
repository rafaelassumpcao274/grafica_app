import 'package:drift/drift.dart';
import 'fatura_table.dart';
import '../config/sqlite_epoch_ms_date_time_converter.dart';

class ParcelaTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get faturaId => integer().references(FaturaTable, #id)();

  IntColumn get numero => integer().withDefault(const Constant(1))();

  RealColumn get valor => real().withDefault(const Constant(0.0))();

  IntColumn get dataEmissao => integer().map(const SqliteEpochMsDateTimeConverter()).withDefault(Constant(DateTime.now().millisecondsSinceEpoch))();

  IntColumn get vencimento => integer().map(const SqliteEpochMsDateTimeConverter())();

  TextColumn get status => text().withDefault(const Constant('ABERTA'))();
}
