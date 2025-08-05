import '../../../domain/entities/formato.dart';
import '../../../domain/repositories/formato_repository.dart';
import '../app_database.dart';
import 'package:drift/drift.dart';

class FormatoRepositoryImpl implements FormatoRepository {
  final AppDatabase db;
  FormatoRepositoryImpl(this.db);

  @override
  Future<List<Formato>> getFormatos() async {
    final result = await db.select(db.formatoTable).get();
    return result
        .map((e) => Formato(id: e.id, descricao: e.descricao))
        .toList();
  }

  @override
  Future<void> addFormato(Formato formato) async {
    await db.into(db.formatoTable).insert(
          FormatoTableCompanion(
            id: Value(formato.id),
            descricao: Value(formato.descricao),
          ),
        );
  }

  @override
  Future<void> updateFormato(Formato formato) async {
    await db.update(db.formatoTable).replace(
          FormatoTableCompanion(
            id: Value(formato.id),
            descricao: Value(formato.descricao),
          ),
        );
  }

  @override
  Future<void> deleteFormato(String id) async {
    await (db.delete(db.formatoTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<List<Formato>> getFormatosPaginated({
    String search = '', 
    int page = 1, 
    int pageSize = 10
  }) async {
    final query = db.select(db.formatoTable);
    
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
    return result.map((e) => Formato(
      id: e.id,
      descricao: e.descricao,
    )).toList();
  }
  

}
