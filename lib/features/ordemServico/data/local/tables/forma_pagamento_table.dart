import 'package:drift/drift.dart';

class FormaPagamentoTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 32)();

  TextColumn get descricao => text().withLength(min: 1, max: 64)();

  @override
  Set<Column> get primaryKey => {id};
}
