import '../../../domain/entities/clientes.dart';
import '../../../domain/repositories/clientes_repository.dart';
import '../app_database.dart';
import 'package:drift/drift.dart';

class ClientesRepositoryImpl implements ClientesRepository {
final AppDatabase db;
  ClientesRepositoryImpl(this.db);

  @override
  Future<List<Clientes>> getClientesPaginated({
    String search = '', 
    int page = 1, 
    int pageSize = 10
  }) async {
    final query = db.select(db.clientesTable);
    
    if (search.isNotEmpty) {
      // Busca mais flexível - tanto por nome quanto por documento
      query.where((tbl) => 
        tbl.nomeEmpresa.like('%$search%') | 
        tbl.documento.like('%$search%') |
        (tbl.email.isNotNull() & tbl.email.like('%$search%'))
      );
    }
    
    // Ordena por nome para melhor UX
    query.orderBy([(tbl) => OrderingTerm.asc(tbl.nomeEmpresa)]);
    
    query.limit(pageSize, offset: (page - 1) * pageSize);
    
    final result = await query.get();
    return result.map((e) => Clientes(
      id: e.id,
      nomeEmpresa: e.nomeEmpresa,
      documento: e.documento,
      email: e.email,
      contato: e.contato,
      telefone: e.telefone,
    )).toList();
  }

  // Método específico para autocomplete
  Future<List<Clientes>> searchClientesForAutocomplete(String search) async {
    if (search.isEmpty) return [];
    
    final query = db.select(db.clientesTable);
    query.where((tbl) => tbl.nomeEmpresa.like('%$search%'));
    query.orderBy([(tbl) => OrderingTerm.asc(tbl.nomeEmpresa)]);
    query.limit(20); // Limite razoável para autocomplete
    
    final result = await query.get();
    return result.map((e) => Clientes(
      id: e.id,
      nomeEmpresa: e.nomeEmpresa,
      documento: e.documento,
      email: e.email,
      contato: e.contato,
      telefone: e.telefone,
    )).toList();
  }

  // Mantenha os outros métodos como estão...
  @override
  Future<List<Clientes>> getClientes() async {
    final result = await db.select(db.clientesTable).get();
    if (result.isEmpty) return [];
    return result.map((e) => Clientes(
      id: e.id,
      nomeEmpresa: e.nomeEmpresa,
      documento: e.documento,
      email: e.email,
      contato: e.contato,
      telefone: e.telefone,
    )).toList();
  }

  

  @override
  Future<void> addClientes(Clientes clientes) async {
    await db.into(db.clientesTable).insert(
          ClientesTableCompanion(
            id: Value(clientes.id),
            nomeEmpresa: Value(clientes.nomeEmpresa),
            documento: Value(clientes.documento),
            email: clientes.email != null
                ? Value(clientes.email!)
                : const Value.absent(),
            contato: clientes.contato != null
                ? Value(clientes.contato!)
                : const Value.absent(),
            telefone: clientes.telefone != null
                ? Value(clientes.telefone!)
                : const Value.absent(),
          ),
        );
  }

  @override
  Future<void> updateClientes(Clientes clientes) async {
    await db.update(db.clientesTable).replace(
          ClientesTableCompanion(
            id: Value(clientes.id),
            nomeEmpresa: Value(clientes.nomeEmpresa),
            documento: Value(clientes.documento),
            email: clientes.email != null
                ? Value(clientes.email!)
                : const Value.absent(),
            contato: clientes.contato != null
                ? Value(clientes.contato!)
                : const Value.absent(),
            telefone: clientes.telefone != null
                ? Value(clientes.telefone!)
                : const Value.absent(),
          ),
        );
  }

  @override
  Future<void> deleteClientes(String id) async {
    await (db.delete(db.clientesTable)..where((tbl) => tbl.id.equals(id))).go();
  }
  
  
}
