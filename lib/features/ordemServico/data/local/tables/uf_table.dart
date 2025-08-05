import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class UfTable extends Table {
  TextColumn get id => text().clientDefault(() =>   Uuid().v4())();
  TextColumn get descricao => text()();
  TextColumn get sigla => text().withLength(min: 2, max: 2)();

  @override
  Set<Column> get primaryKey => {id};
}
