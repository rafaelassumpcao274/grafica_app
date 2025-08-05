import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class EnderecosTable extends Table {
  TextColumn get id => text().clientDefault(() =>   Uuid().v4())();
  TextColumn get logradouro => text()();
  IntColumn get cep => integer()();
  TextColumn get complemento => text()();
  IntColumn get numero => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
