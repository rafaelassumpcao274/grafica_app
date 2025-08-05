import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class PapelTable extends Table {
  TextColumn get id => text().clientDefault(() =>   Uuid().v4())();
  TextColumn get descricao => text()();
  IntColumn get quantidadePapel => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
