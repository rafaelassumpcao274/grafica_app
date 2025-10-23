

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/fornecedorOrdemServico.dart';

import '../../../domain/entities/fornecedor.dart';

final fornecedorCustoControllerProvider =
ChangeNotifierProvider<FornecedorCustoController>((ref) {
  return FornecedorCustoController();
});


class FornecedorCustoController extends ValueNotifier<List<FornecedorOrdemServico>>{
  FornecedorCustoController(): super([]);


  void setFornecedores(List<FornecedorOrdemServico> fornecedores) {
    value = fornecedores;
  }

  void addFornecedor(Fornecedor fornecedor) {
    if (!value.any((f) => f.fornecedor?.id == fornecedor.id)) {
      value = [...value, FornecedorOrdemServico(fornecedor: fornecedor)];
    }
  }

  void updateFornecedor(int index, String valor) {
    final parsed = double.tryParse(valor.replaceAll(',', '.')) ?? 0.0;
    final updated = [...value];
    updated[index] = updated[index].copyWith(custo: parsed);
    value = updated;
  }

  double get totalCusto => value.fold(0.0, (a, b) => a + b.custo);

  void removeFornecedor(int index) {
    value = [...value]..removeAt(index);
  }

}