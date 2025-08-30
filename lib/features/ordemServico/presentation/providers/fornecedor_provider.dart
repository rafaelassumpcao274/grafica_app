import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/fornecedor.dart';


import '../../data/local/app_database.dart';
import '../../data/local/repositories/fornecedor_repository_impl.dart';
import '../../data/local/repositories/ordemservico_repository_impl.dart';
import '../../domain/entities/ordemservico.dart';


final dbProvider = FutureProvider<AppDatabase>((ref) async {
  return await AppDatabase.getInstance();
});


final fornecedorProvider =
AsyncNotifierProvider<FornecedorNotifier, List<Fornecedor>>(
    FornecedorNotifier.new);


class FornecedorNotifier extends AsyncNotifier<List<Fornecedor>> {
  late FornecedorRepositoryImpl repository;

  @override
  Future<List<Fornecedor>> build() async {
    await Future.delayed(const Duration(seconds: 2)); // simula carregamento lento
    final db = await ref.watch(dbProvider.future);
    repository = FornecedorRepositoryImpl(db);
    return await repository.getFornecedores();
  }

  Future<void> loadFornecedor() async {
     state = AsyncValue.data(await repository.getFornecedores());
  }


  Future<Fornecedor?> getById(String id) async {
    final fornecedores = await repository.getFornecedores();
    try {
      return fornecedores.firstWhere((fornecedor) => fornecedor.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Fornecedor>> getFornecedoresByNome(String nomeParcial) async {
    print('🔍 Buscando por: "$nomeParcial"');

    try {
      // CORREÇÃO: Passe o nomeParcial como search parameter
      final fornecedores = await repository.getFornecedorPaginated(
        search: nomeParcial,
        pageSize: 20, // Aumente o limite para pegar mais resultados
      );

      print('📊 Fornecedores encontrados: ${fornecedores.length}');
      return fornecedores;

    } catch (e) {
      print('❌ Erro na busca: $e');
      rethrow;
    }
  }

  Future<void> add(Fornecedor fornecedor) async {
    await repository.add(fornecedor);
    await loadFornecedor();
  }

  Future<void> updateFornecedor( Fornecedor fornecedor) async {
    await repository.update(fornecedor);
    await loadFornecedor();
  }

  Future<void> delete(String id) async {
    await repository.delete(id);
    await loadFornecedor();
  }
}


