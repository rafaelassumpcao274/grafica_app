import 'package:drift/drift.dart';

class SqliteDateTimeConverter extends TypeConverter<DateTime, String> {
  const SqliteDateTimeConverter();

  @override
  DateTime fromSql(String fromDb) {
    if( fromDb == 'CURRENT_TIMESTAMP') {
      return DateTime.now(); // Return current time if the database value is null or empty
    }
    return DateTime.parse(fromDb.replaceFirst(' ', 'T'));
  }

  @override
  String toSql(DateTime value) {
    return value.toIso8601String().replaceFirst('T', ' ');
  }
}
