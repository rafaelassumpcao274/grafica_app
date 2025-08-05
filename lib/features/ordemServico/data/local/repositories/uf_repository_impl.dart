import '../../../domain/entities/uf.dart';
import '../../../domain/repositories/uf_repository.dart';
import '../app_database.dart';
import 'package:drift/drift.dart';

class UfRepositoryImpl implements UfRepository {
  final AppDatabase db;
  UfRepositoryImpl(this.db);

  @override
  Future<List<Uf>> getUfs() async {
    final result = await db.select(db.ufTable).get();
    return result
        .map((e) => Uf(id: e.id, descricao: e.descricao, sigla: e.sigla))
        .toList();
  }

  @override
  Future<void> addUf(Uf uf) async {
    await db.into(db.ufTable).insert(
          UfTableCompanion(
            id: Value(uf.id),
            descricao: Value(uf.descricao),
            sigla: Value(uf.sigla),
          ),
        );
  }

  @override
  Future<void> updateUf(Uf uf) async {
    await db.update(db.ufTable).replace(
          UfTableCompanion(
            id: Value(uf.id),
            descricao: Value(uf.descricao),
            sigla: Value(uf.sigla),
          ),
        );
  }

  @override
  Future<void> deleteUf(String id) async {
    await (db.delete(db.ufTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
