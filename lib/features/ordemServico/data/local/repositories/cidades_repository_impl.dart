import '../../../domain/entities/cidades.dart';
import '../../../domain/repositories/cidades_repository.dart';
import '../app_database.dart';
import 'package:drift/drift.dart';

class CidadesRepositoryImpl implements CidadesRepository {
  final AppDatabase db;
  CidadesRepositoryImpl(this.db);

  @override
  Future<List<Cidades>> getCidades() async {
    final result = await db.select(db.cidadesTable).get();
    return result
        .map((e) => Cidades(id: e.id, descricao: e.descricao))
        .toList();
  }

  @override
  Future<void> addCidades(Cidades cidades) async {
    await db.into(db.cidadesTable).insert(CidadesTableCompanion(
          id: Value(cidades.id),
          descricao: Value(cidades.descricao),
        ));
  }

  @override
  Future<void> updateCidades(Cidades cidades) async {
    await db.update(db.cidadesTable).replace(CidadesTableCompanion(
          id: Value(cidades.id),
          descricao: Value(cidades.descricao),
        ));
  }

  @override
  Future<void> deleteCidades(String id) async {
    await (db.delete(db.cidadesTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
