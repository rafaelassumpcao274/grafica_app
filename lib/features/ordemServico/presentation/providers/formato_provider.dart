import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/formato.dart';
import '../../domain/provider/providers.dart';
import '../../domain/repositories/formato_repository.dart';

class FormatoNotifier extends StateNotifier<List<Formato>> {
  final FormatoRepository repository;

  FormatoNotifier(this.repository) : super([]) {
    loadFormatos();
  }

  Future<void> loadFormatos() async {
    state = await repository.getFormatos();
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

  Future<Formato?> getClienteById(String id) async {
    final formatos = await repository.getFormatos();
    try {
      return formatos.firstWhere((formato) => formato.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> addCliente(Formato formato) async {
    await repository.addFormato(formato);
    await loadFormatos();
  }

  Future<void> updateCliente(Formato formato) async {
    await repository.updateFormato(formato);
    await loadFormatos();
  }

  Future<void> deleteCliente(String id) async {
    await repository.deleteFormato(id);
    await loadFormatos();
  }
}

final formatoProvider = FutureProvider<FormatoNotifier>((ref) async {
  final repository = await ref.watch(formatoRepositoryProvider.future);
  return FormatoNotifier(repository);
});
