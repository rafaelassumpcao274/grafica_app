import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/data/local/repositories/papel_repository_impl.dart';

import '../../data/local/app_database.dart';
import '../../domain/entities/papel.dart';


final dbProvider = FutureProvider<AppDatabase>((ref) async {
  return await AppDatabase.getInstance();
});

final papelProvider =
AsyncNotifierProvider<PapelNotifier, List<Papel>>(
    PapelNotifier.new);


// Provider para busca dinâmica de papeis
final searchPapelProvider =
FutureProvider.family<List<Papel>, String>((ref, query) async {
  if (query.isEmpty) return [];

  final notifier = await ref.watch(papelProvider.notifier);
  return notifier.getPapeisByNome(query);
});


class PapelNotifier extends AsyncNotifier<List<Papel>> {
  late PapelRepositoryImpl repository;

  @override
  Future<List<Papel>> build() async {
    await Future.delayed(const Duration(seconds: 2)); // simula carregamento lento
    final db = await ref.watch(dbProvider.future);
    repository = PapelRepositoryImpl(db);
    return await repository.getPapeis();
  }

  Future<void> loadPapel() async {
    state = AsyncValue.data(await repository.getPapeis());
  }


  Future<Papel?> getById(String id) async {
    final papeis = await repository.getPapeis();
    try {
      return papeis.firstWhere((papel) => papel.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Papel>> getPapeisByNome(String nomeParcial) async {
    print('🔍 Buscando por: "$nomeParcial"');

    try {

      final papeis = await repository.getPapelPaginated(
        search: nomeParcial,
        pageSize: 20,
      );

      return papeis;

    } catch (e) {
      print('❌ Erro na busca: $e');
      rethrow;
    }
  }

  Future<void> add(Papel papel) async {
    await repository.addPapel(papel);
    await loadPapel();
  }

  Future<void> updatePapel( Papel papel) async {
    await repository.updatePapel(papel);
    await loadPapel();
  }

  Future<void> delete(String id) async {
    await repository.deletePapel(id);
    await loadPapel();
  }
}
