import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/via_cores.dart';

import '../../data/local/app_database.dart';
import '../../data/local/repositories/viacores_repository_impl.dart';


final dbProvider = FutureProvider<AppDatabase>((ref) async {
  return await AppDatabase.getInstance();
});

final viacoresProvider =
AsyncNotifierProvider<ViaCoresNotifier, List<ViaCores>>(
    ViaCoresNotifier.new);


class ViaCoresNotifier extends AsyncNotifier<List<ViaCores>> {
  late ViaCoresRepositoryImpl repository;

  @override
  Future<List<ViaCores>> build() async {
    final db = await ref.watch(dbProvider.future);
    repository = ViaCoresRepositoryImpl(db);
    return await repository.getViaCores();
  }

  Future<void> loadViaCores() async {
    state = AsyncValue.data(await repository.getViaCores());
  }



  Future<ViaCores?> getById(String id) async {
    final papeis = await repository.getViaCores();
    try {
      return papeis.firstWhere((papel) => papel.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<ViaCores>> getViaByNome(String nomeParcial) async {
    print('🔍 Buscando por: "$nomeParcial"');

    try {

      final papeis = await repository.getViaCoresPaginated(
        search: nomeParcial,
        pageSize: 20,
      );

      return papeis;

    } catch (e) {
      print('❌ Erro na busca: $e');
      rethrow;
    }
  }

  Future<void> add(ViaCores papel) async {
    await repository.addViaCores(papel);
    await loadViaCores();
  }

  Future<void> updateViaCores(ViaCores papel) async {
    await repository.updateViaCores(papel);
    await loadViaCores();
  }

  Future<void> delete(String id) async {
    await repository.deleteViaCores(id);
    await loadViaCores();
  }
}
