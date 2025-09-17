import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/fornecedor_provider.dart';

import '../../../domain/entities/fornecedor.dart';
import '../../../domain/entities/fornecedorOrdemServico.dart';

/// Provider da ViewModel
final fornecedorCustoViewModelProvider = StateNotifierProvider<
    FornecedorCustoViewModel, List<FornecedorOrdemServico>>((ref) {
  return FornecedorCustoViewModel();
});

final searchFornecedorProvider =
    FutureProvider.family<List<Fornecedor>, String>((ref, query) async {
  if (query.isEmpty) return [];

  final notifier = await ref.watch(fornecedorProvider.notifier);
  return notifier.getFornecedoresByNome(query);
});

class FornecedorCustoViewModel
    extends StateNotifier<List<FornecedorOrdemServico>> {
  /// controllers para inputs de custo
  final Map<String, TextEditingController> _controllers = {};

  FornecedorCustoViewModel() : super([]);

  double get totalCusto => state.fold(0.0, (a, b) => a + b.custo);

  /// limpa a lista ao iniciar
  void clear() {
    state = [];
    _controllers.clear();
  }

  void setFornecedores(List<FornecedorOrdemServico> fornecedores) {
    state = fornecedores;
  }

  /// adiciona fornecedor à lista
  void addFornecedor(Fornecedor fornecedor) {
    if (!state.any((f) => f.fornecedor?.id == fornecedor.id)) {
      state = [...state, FornecedorOrdemServico(fornecedor: fornecedor)];
    }
  }

  /// remove fornecedor por índice
  void removeFornecedor(int index) {
    final removed = state[index];
    _controllers.remove(removed.id);
    state = [...state]..removeAt(index);
  }

  /// retorna ou cria controller para campo de custo
  TextEditingController getController(FornecedorOrdemServico fornecedor) {
    return _controllers.putIfAbsent(
      fornecedor.id,
      () => TextEditingController(
        text: fornecedor.custo.toStringAsFixed(2) ?? "",
      ),
    );
  }

  /// atualiza valor do fornecedor na lista
  void updateFornecedor(int index, String valor) {
    final parsed = double.tryParse(valor.replaceAll(',', '.')) ?? 0.0;
    final updated = [...state];
    updated[index] = updated[index].copyWith(custo: parsed);
    state = updated;
  }
}
