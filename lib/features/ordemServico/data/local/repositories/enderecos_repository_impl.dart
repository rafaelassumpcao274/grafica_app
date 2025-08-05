import '../../../domain/entities/enderecos.dart';
import '../../../domain/repositories/enderecos_repository.dart';
import '../app_database.dart';
import 'package:drift/drift.dart';

class EnderecosRepositoryImpl implements EnderecosRepository {
  final AppDatabase db;
  EnderecosRepositoryImpl(this.db);

  @override
  Future<List<Enderecos>> getEnderecos() async {
    final result = await db.select(db.enderecosTable).get();
    return result
        .map((e) => Enderecos(
              id: e.id,
              logradouro: e.logradouro,
              cep: e.cep,
              complemento: e.complemento,
              numero: e.numero,
            ))
        .toList();
  }

  @override
  Future<void> addEnderecos(Enderecos enderecos) async {
    await db.into(db.enderecosTable).insert(
          EnderecosTableCompanion(
            id: Value(enderecos.id),
            logradouro: Value(enderecos.logradouro),
            cep: Value(enderecos.cep),
            complemento: Value(enderecos.complemento),
            numero: Value(enderecos.numero),
          ),
        );
  }

  @override
  Future<void> updateEnderecos(Enderecos enderecos) async {
    await db.update(db.enderecosTable).replace(
          EnderecosTableCompanion(
            id: Value(enderecos.id),
            logradouro: Value(enderecos.logradouro),
            cep: Value(enderecos.cep),
            complemento: Value(enderecos.complemento),
            numero: Value(enderecos.numero),
          ),
        );
  }

  @override
  Future<void> deleteEnderecos(String id) async {
    await (db.delete(db.enderecosTable)..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
