import 'package:drift/drift.dart';
import '../config/sqlite_epoch_ms_date_time_converter.dart';

class DespesaTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get descricao => text()();

  RealColumn get valor => real().withDefault(const Constant(0.0))();

  IntColumn get data => integer().map(const SqliteEpochMsDateTimeConverter())();

  TextColumn get status => text().withDefault(const Constant('ABERTA'))();
}
