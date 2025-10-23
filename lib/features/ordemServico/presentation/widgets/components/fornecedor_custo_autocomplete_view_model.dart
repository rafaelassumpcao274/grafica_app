import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/fornecedor_provider.dart';

import '../../../domain/entities/fornecedor.dart';
import '../../../domain/entities/fornecedorOrdemServico.dart';
import '../../../domain/provider/providers.dart';
import '../../../domain/repositories/fornecedor_repository.dart';
import '../fornecedor/fornecedor_custo_controller.dart';

/// Provider da ViewModel
// Provider do ViewModel
final fornecedorCustoViewModelProvider =
ChangeNotifierProvider.family<FornecedorCustoViewModel, FornecedorCustoController>(
      (ref, fornecedorController) {
    final notifier = ref.watch(fornecedorNotifierProvider.notifier);
    final vm = FornecedorCustoViewModel(notifier,fornecedorController);
    return vm;
  },
);

class FornecedorCustoViewModel extends ChangeNotifier {
  final FornecedorNotifier? repository;
  final Map<String, TextEditingController> _controllers = {};
  final FornecedorCustoController fornecedorController;


  FornecedorCustoViewModel(this.repository,this.fornecedorController);




  void clear() {
    _controllers.clear();

  }

  void setFornecedores(List<FornecedorOrdemServico> fornecedores) {
    fornecedorController.setFornecedores(fornecedores);

  }

  void addFornecedor(Fornecedor fornecedor) {
    fornecedorController.addFornecedor(fornecedor);

  }

  void removeFornecedor(int index) {
    final removed = fornecedorController.value[index];
    _controllers.remove(removed.id);
    fornecedorController.removeFornecedor(index);

  }

  TextEditingController getController(FornecedorOrdemServico fornecedor) {
    return _controllers.putIfAbsent(
      fornecedor.id,
          () =>
          TextEditingController(
            text: fornecedor.custo.toStringAsFixed(2),
          ),
    );
  }

  void updateFornecedor(int index, String valor) {
    fornecedorController.updateFornecedor(index, valor);
  }

  /// 🔎 Busca fornecedores por nome direto no repository
  Future<List<Fornecedor>> searchFornecedores(String query) async {
    if (repository == null) return [];
    if (query.isEmpty) return await repository!.build();
    return repository!.searchFornecedores(query);
  }
}
