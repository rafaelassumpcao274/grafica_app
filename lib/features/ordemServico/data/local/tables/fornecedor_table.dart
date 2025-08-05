import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class FornecedorTable extends Table {
  TextColumn get id => text().clientDefault(() =>   Uuid().v4())();
  TextColumn get descricao => text()();
  RealColumn get preco => real()();

  @override
  Set<Column> get primaryKey => {id};
}
