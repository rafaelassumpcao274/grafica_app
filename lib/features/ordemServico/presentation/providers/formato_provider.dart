import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/app_database.dart';
import '../../data/local/repositories/formato_repository_impl.dart';
import '../../domain/entities/formato.dart';



final dbProvider = FutureProvider<AppDatabase>((ref) async {
  return await AppDatabase.getInstance();
});

final formatoRepositoryProvider =
    FutureProvider<FormatoRepositoryImpl>((ref) async {
  final db = await ref.watch(dbProvider.future);
  return FormatoRepositoryImpl(db);
});

class FormatoNotifier extends StateNotifier<List<Formato>> {
  final FormatoRepositoryImpl repository;

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
        search: descricao,
        pageSize: 50
      );

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