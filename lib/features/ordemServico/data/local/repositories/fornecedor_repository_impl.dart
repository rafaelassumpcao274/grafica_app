import 'package:unilith_app/features/ordemServico/data/local/mappers/fornecedor_mapper.dart';

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
            (data) =>  Fornecedor(
                id: data.id,
                nome: data.nome,
                contato: data.contato,
                telefone: data.telefone,
                email: data.email,
                observacao: data.observacao,
                tipoServico: data.tipoServico
            ))
        .toList();
  }

  @override
  Future<void> add(Fornecedor entity) async {
    await db.into(db.fornecedorTable).insert(
      FornecedorTableCompanion(
          id: Value(entity.id),
          nome: Value(entity.nome),
          contato: Value(entity.contato),
          telefone: Value(entity.telefone),
          email: Value(entity.email),
          observacao: Value(entity.observacao),
          tipoServico: Value(entity.tipoServico)
      ),
        );
  }

  @override
  Future<void> update(Fornecedor entity) async {
    await db.update(db.fornecedorTable).replace(
      FornecedorTableCompanion(
          id: Value(entity.id),
          nome: Value(entity.nome),
          contato: Value(entity.contato),
          telefone: Value(entity.telefone),
          email: Value(entity.email),
          observacao: Value(entity.observacao),
          tipoServico: Value(entity.tipoServico)
      ),
        );
  }

  @override
  Future<void> delete(String id) async {
    await (db.delete(db.fornecedorTable)..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
