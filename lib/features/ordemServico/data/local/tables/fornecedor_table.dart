import 'package:drift/drift.dart';
import 'package:unilith_app/features/ordemServico/data/local/config/sqlite_tipo_servico_converter.dart';
import 'package:uuid/uuid.dart';

class FornecedorTable extends Table {
  TextColumn get id => text().clientDefault(() =>   Uuid().v4())();
  TextColumn get nome => text()();
  TextColumn get contato => text()();
  TextColumn get telefone => text()();
  TextColumn get email => text()();
  TextColumn get observacao => text()();
  TextColumn get tipoServico => text().map(const SqliteTipoServicoConverter())();


  @override
  Set<Column> get primaryKey => {id};
}
