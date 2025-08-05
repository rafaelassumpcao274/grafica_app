import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../data/local/app_database.dart';
import '../../data/local/repositories/ordemservico_repository_impl.dart';
import '../../domain/entities/ordemservico.dart';


final dbProvider = FutureProvider<AppDatabase>((ref) async {
  return await AppDatabase.getInstance();
});


final ordemServicoProvider =
AsyncNotifierProvider<OrdemServicoNotifier, List<OrdemServico>>(
    OrdemServicoNotifier.new);


class OrdemServicoNotifier extends AsyncNotifier<List<OrdemServico>> {
  late OrdemServicoRepositoryImpl repository;

  @override
  Future<List<OrdemServico>> build() async {
    await Future.delayed(const Duration(seconds: 2)); // simula carregamento lento
    final db = await ref.watch(dbProvider.future);
    repository = OrdemServicoRepositoryImpl(db);
    return await repository.getOrdensServico();
  }

  Future<void> loadOrdemServicos() async {
     state = AsyncValue.data(await repository.getOrdensServico());
  }


  Future<OrdemServico?> getById(int id) async {
    final ordemServicos = await repository.getOrdensServico();
    try {
      return ordemServicos.firstWhere((ordemservico) => ordemservico.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> add(OrdemServico ordemservico) async {
    await repository.add(ordemservico);
    await loadOrdemServicos();
  }

  Future<void> updateOS( OrdemServico ordemservico) async {
    await repository.update(ordemservico);
    await loadOrdemServicos();
  }




  Future<void> delete(int id) async {
    await repository.delete(id);
    await loadOrdemServicos();
  }
}


