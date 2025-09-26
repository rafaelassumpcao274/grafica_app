import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/fornecedor_provider.dart';

import '../../../domain/entities/fornecedor.dart';
import '../../../domain/entities/fornecedorOrdemServico.dart';
import '../../../domain/provider/providers.dart';
import '../../../domain/repositories/fornecedor_repository.dart';

/// Provider da ViewModel
// Provider do ViewModel
final fornecedorCustoViewModelProvider = StateNotifierProvider<
    FornecedorCustoViewModel, List<FornecedorOrdemServico>>((ref) {
  final repositoryAsync = ref.watch(fornecedorRepositoryProvider);

  return repositoryAsync.when(
    data: (repository) => FornecedorCustoViewModel(repository),
    loading: () => FornecedorCustoViewModel(null), // sem repo ainda
    error: (err, stack) => FornecedorCustoViewModel(null), // sem repo em caso de erro
  );
});


class FornecedorCustoViewModel extends StateNotifier<List<FornecedorOrdemServico>> {
  final FornecedorRepository? repository;
  final Map<String, TextEditingController> _controllers = {};

  FornecedorCustoViewModel(this.repository) : super([]);

  double get totalCusto => state.fold(0.0, (a, b) => a + b.custo);

  void clear() {
    state = [];
    _controllers.clear();
  }

  void setFornecedores(List<FornecedorOrdemServico> fornecedores) {
    state = fornecedores;
  }

  void addFornecedor(Fornecedor fornecedor) {
    if (!state.any((f) => f.fornecedor?.id == fornecedor.id)) {
      state = [...state, FornecedorOrdemServico(fornecedor: fornecedor)];
    }
  }

  void removeFornecedor(int index) {
    final removed = state[index];
    _controllers.remove(removed.id);
    state = [...state]..removeAt(index);
  }

  TextEditingController getController(FornecedorOrdemServico fornecedor) {
    return _controllers.putIfAbsent(
      fornecedor.id,
          () => TextEditingController(
        text: fornecedor.custo.toStringAsFixed(2),
      ),
    );
  }

  void updateFornecedor(int index, String valor) {
    final parsed = double.tryParse(valor.replaceAll(',', '.')) ?? 0.0;
    final updated = [...state];
    updated[index] = updated[index].copyWith(custo: parsed);
    state = updated;
  }

  /// 🔎 Busca fornecedores por nome direto no repository
  Future<List<Fornecedor>> searchFornecedores(String query) async {
    if(repository == null) return [];
    if (query.isEmpty) return await repository!.getFornecedores() ;
    return repository!.getFornecedorPaginated(search: query);
  }
}


