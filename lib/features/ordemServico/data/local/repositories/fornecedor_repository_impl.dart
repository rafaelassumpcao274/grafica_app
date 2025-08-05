import '../../../domain/entities/fornecedor.dart';
import '../../../domain/repositories/fornecedor_repository.dart';
import '../app_database.dart';
import 'package:drift/drift.dart';

class FornecedorRepositoryImpl implements FornecedorRepository {
  final AppDatabase db;
  FornecedorRepositoryImpl(this.db);

  @override
  Future<List<Fornecedor>> getFornecedores() async {
    final result = await db.select(db.fornecedorTable).get();
    return result
        .map(
            (e) => Fornecedor(id: e.id, descricao: e.descricao, preco: e.preco))
        .toList();
  }

  @override
  Future<void> addFornecedor(Fornecedor fornecedor) async {
    await db.into(db.fornecedorTable).insert(
          FornecedorTableCompanion(
            id: Value(fornecedor.id),
            descricao: Value(fornecedor.descricao),
            preco: Value(fornecedor.preco),
          ),
        );
  }

  @override
  Future<void> updateFornecedor(Fornecedor fornecedor) async {
    await db.update(db.fornecedorTable).replace(
          FornecedorTableCompanion(
            id: Value(fornecedor.id),
            descricao: Value(fornecedor.descricao),
            preco: Value(fornecedor.preco),
          ),
        );
  }

  @override
  Future<void> deleteFornecedor(String id) async {
    await (db.delete(db.fornecedorTable)..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
