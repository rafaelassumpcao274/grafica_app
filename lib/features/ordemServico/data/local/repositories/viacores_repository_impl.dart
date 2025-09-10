import '../../../domain/entities/via_cores.dart';
import '../../../domain/repositories/viacores_repository.dart';
import '../app_database.dart';
import 'package:drift/drift.dart';

class ViaCoresRepositoryImpl implements ViaCoresRepository {
  final AppDatabase db;
  ViaCoresRepositoryImpl(this.db);

  @override
  Future<List<ViaCores>> getViaCores() async {
    final result = await db.select(db.viaCoresTable).get();
    return result
        .map((e) => ViaCores(id: e.id, descricao: e.descricao))
        .toList();
  }

  @override
  Future<void> addViaCores(ViaCores viaCores) async {
    await db.into(db.viaCoresTable).insert(
          ViaCoresTableCompanion(
            id: Value(viaCores.id),
            descricao: Value(viaCores.descricao),
          ),
        );
  }

  @override
  Future<void> updateViaCores(ViaCores viaCores) async {
    await db.update(db.viaCoresTable).replace(
          ViaCoresTableCompanion(
            id: Value(viaCores.id),
            descricao: Value(viaCores.descricao),
          ),
        );
  }

  @override
  Future<void> deleteViaCores(String id) async {
    await (db.delete(db.viaCoresTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<List<ViaCores>> getViaCoresPaginated({
    String search = '', 
    int page = 1, 
    int pageSize = 10
  }) async {
    final query = db.select(db.viaCoresTable);
    
    if (search.isNotEmpty) {
      // Busca mais flexível - tanto por nome quanto por documento
      query.where((tbl) => 
        tbl.descricao.like('%$search%')
      );
    }
    
    // Ordena por nome para melhor UX
    query.orderBy([(tbl) => OrderingTerm.asc(tbl.descricao)]);
    
    query.limit(pageSize, offset: (page - 1) * pageSize);
    
    final result = await query.get();
    return result.map((e) => ViaCores(
      id: e.id,
      descricao: e.descricao,
      
    )).toList();
  }
}
