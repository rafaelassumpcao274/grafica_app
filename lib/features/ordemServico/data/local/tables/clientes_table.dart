import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class ClientesTable extends Table {
  TextColumn get id => text().clientDefault(() => Uuid().v4())();

  TextColumn get nomeEmpresa => text()();

  TextColumn get documento => text().withLength(min: 0, max: 14)();

  TextColumn get email => text().nullable()();

  TextColumn get contato => text().nullable()();

  TextColumn get telefone => text().withLength(min: 0, max: 11).nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
