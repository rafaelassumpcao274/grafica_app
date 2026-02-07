import 'package:drift/drift.dart';

class SqliteDateTimeConverter extends TypeConverter<DateTime, String> {
  const SqliteDateTimeConverter();

  @override
  DateTime fromSql(String fromDb) {
    return DateTime.parse(fromDb.replaceFirst(' ', 'T'));
  }

  @override
  String toSql(DateTime value) {
    return value.toIso8601String().replaceFirst('T', ' ');
  }
}

