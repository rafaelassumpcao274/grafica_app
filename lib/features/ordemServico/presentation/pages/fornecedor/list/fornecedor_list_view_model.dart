import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/fornecedor.dart';
import '../../../providers/fornecedor_provider.dart';

class FornecedorListViewModel extends ChangeNotifier {
  final FornecedorNotifier notifier;

  List<Fornecedor> fornecedores = [];
  bool isLoading = false;

  FornecedorListViewModel(this.notifier) {
    loadFornecedores();
  }

  Future<void> loadFornecedores() async {
    isLoading = true;
    notifyListeners();

    fornecedores = [...?notifier.state.value ?? []];

    isLoading = false;
    notifyListeners();
  }

  /// Filtro puro (não muta estado nem notifica) — seguro para chamar
  /// direto no build().
  List<Fornecedor> filter(String filtro) {
    if (filtro.isEmpty) return fornecedores;
    return fornecedores
        .where((f) => f.nome.toLowerCase().contains(filtro.toLowerCase()))
        .toList();
  }

  Future<void> deleteFornecedor(String id) async {
    await notifier.deleteFornecedor(id);
    await loadFornecedores();
  }
}


final fornecedorListViewModelProvider =
ChangeNotifierProvider.family<FornecedorListViewModel, FornecedorNotifier>(
      (ref, notifier) {
    return FornecedorListViewModel(notifier);
  },
);
