import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/fornecedor_ordem_servico.dart';

class FornecedorCustoNotifier extends StateNotifier<List<FornecedorOrdemServico>> {
  FornecedorCustoNotifier() : super([]);

  void setFornecedores(List<FornecedorOrdemServico> fornecedores) {
    state = fornecedores;
  }

  void addFornecedor(FornecedorOrdemServico fornecedor) {
    state = [...state, fornecedor];
  }

  void updateFornecedor(int index, FornecedorOrdemServico fornecedor) {
    final newList = [...state];
    newList[index] = fornecedor;
    state = newList;
  }

  void removeFornecedor(int index) {
    final newList = [...state]..removeAt(index);
    state = newList;
  }

  void clear() {
    state = [];
  }

  double get totalCusto => state.fold(0.0, (a, b) => a + b.custo);
}

final fornecedorCustoProvider =
StateNotifierProvider<FornecedorCustoNotifier, List<FornecedorOrdemServico>>(
      (ref) => FornecedorCustoNotifier(),
);
