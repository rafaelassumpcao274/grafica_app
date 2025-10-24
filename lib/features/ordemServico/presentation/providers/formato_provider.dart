import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/formato.dart';
import '../../domain/provider/providers.dart';
import '../../domain/repositories/formato_repository.dart';

class FormatoNotifier extends AsyncNotifier<List<Formato>> {
  late FormatoRepository repository;

  @override
  Future<List<Formato>> build() async {
    repository = await ref.watch(formatoRepositoryProvider.future);
    return await repository.getFormatos();
  }

  Future<void> loadFormatos() async {
    state = AsyncValue.data(await repository.getFormatos());
  }

  // MÉTODO CORRIGIDO: Use o parâmetro search do repository
  Future<List<Formato>> getFormatoByDescricao(String descricao) async {
    print('🔍 Buscando por: "$descricao"'); // Debug

    try {
      final formatos = await repository.getFormatosPaginated(
          search: descricao, pageSize: 50);

      return formatos;
    } catch (e) {
      print('❌ Erro na busca: $e'); // Debug
      rethrow;
    }
  }

  Future<Formato?> getFormatoById(String id) async {
    final formatos = await repository.getFormatos();
    try {
      return formatos.firstWhere((formato) => formato.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> addFormato(Formato formato) async {
    await repository.addFormato(formato);
    await loadFormatos();
  }

  Future<void> updateFormato(Formato formato) async {
    await repository.updateFormato(formato);
    await loadFormatos();
  }

  Future<void> deleteFormato(String id) async {
    await repository.deleteFormato(id);
    await loadFormatos();
  }
}

final formatoProvider =
    AsyncNotifierProvider<FormatoNotifier, List<Formato>>(FormatoNotifier.new);
