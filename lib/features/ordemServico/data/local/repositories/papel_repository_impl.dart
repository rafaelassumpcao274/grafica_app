import '../../../domain/entities/papel.dart';
import '../../../domain/repositories/papel_repository.dart';
import '../app_database.dart';
import 'package:drift/drift.dart';

class PapelRepositoryImpl implements PapelRepository {
  final AppDatabase db;
  PapelRepositoryImpl(this.db);

  @override
  Future<List<Papel>> getPapeis() async {
    final result = await db.select(db.papelTable).get();
    return result
        .map((e) => Papel(
            id: e.id,
            descricao: e.descricao,
            quantidadePapel: e.quantidadePapel))
        .toList();
  }

  @override
  Future<void> addPapel(Papel papel) async {
    await db.into(db.papelTable).insert(
          PapelTableCompanion(
            id: Value(papel.id),
            descricao: Value(papel.descricao),
            quantidadePapel: Value(papel.quantidadePapel),
          ),
        );
  }

  @override
  Future<void> updatePapel(Papel papel) async {
    await db.update(db.papelTable).replace(
          PapelTableCompanion(
            id: Value(papel.id),
            descricao: Value(papel.descricao),
            quantidadePapel: Value(papel.quantidadePapel),
          ),
        );
  }

  @override
  Future<void> deletePapel(String id) async {
    await (db.delete(db.papelTable)..where((tbl) => tbl.id.equals(id))).go();
  }


   @override
  Future<List<Papel>> getPapelPaginated({
    String search = '', 
    int page = 1, 
    int pageSize = 10
  }) async {
    final query = db.select(db.papelTable);
    
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
    return result.map((e) => Papel(
      id: e.id,
      descricao: e.descricao,
      quantidadePapel: e.quantidadePapel,
    )).toList();
  }
  
}
