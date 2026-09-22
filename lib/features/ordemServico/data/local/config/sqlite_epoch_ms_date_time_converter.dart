import 'package:drift/drift.dart';

class SqliteEpochMsDateTimeConverter extends TypeConverter<DateTime, int> {
  const SqliteEpochMsDateTimeConverter();

  @override
  DateTime fromSql(int fromDb) {
    return DateTime.fromMillisecondsSinceEpoch(fromDb);
  }

  @override
  int toSql(DateTime value) {
    return value.millisecondsSinceEpoch;
  }
}
