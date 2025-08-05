import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class FormatoTable extends Table {
  TextColumn get id => text().clientDefault(() =>   Uuid().v4())();
  TextColumn get descricao => text()();

  @override
  Set<Column> get primaryKey => {id};
}
