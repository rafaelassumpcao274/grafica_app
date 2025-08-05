import '../../../domain/entities/custo.dart';
import '../../../domain/repositories/custo_repository.dart';
import '../app_database.dart';
import 'package:drift/drift.dart';

class CustoRepositoryImpl implements CustoRepository {
  final AppDatabase db;
  CustoRepositoryImpl(this.db);

  @override
  Future<List<Custo>> getCustos() async {
    final result = await db.select(db.custoTable).get();
    return result
        .map((e) => Custo(id: e.id, descricao: e.descricao, valor: e.valor))
        .toList();
  }

  @override
  Future<void> addCusto(Custo custo) async {
    await db.into(db.custoTable).insert(
          CustoTableCompanion(
            id: Value(custo.id),
            descricao: Value(custo.descricao),
            valor: Value(custo.valor),
          ),
        );
  }

  @override
  Future<void> updateCusto(Custo custo) async {
    await db.update(db.custoTable).replace(
          CustoTableCompanion(
            id: Value(custo.id),
            descricao: Value(custo.descricao),
            valor: Value(custo.valor),
          ),
        );
  }

  @override
  Future<void> deleteCusto(String id) async {
    await (db.delete(db.custoTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
