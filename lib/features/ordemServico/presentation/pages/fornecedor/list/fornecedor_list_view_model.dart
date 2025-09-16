import 'package:flutter/cupertino.dart';

import '../../../../domain/entities/fornecedor.dart';
import '../../../providers/fornecedor_provider.dart';

class FornecedorListViewModel extends ChangeNotifier {
  final FornecedorNotifier notifier;

  List<Fornecedor> fornecedores = [];
  bool isLoading = false;
  String filter = '';

  FornecedorListViewModel(this.notifier);

  Future<void> loadFornecedores() async {
    isLoading = true;
    notifyListeners();

    fornecedores = await notifier.build();
    if(filter.isNotEmpty){
      applyFilter(filter);
    }

    isLoading = false;
    notifyListeners();
  }

  void applyFilter(String query) async {
    filter = query;
    if (filter.isNotEmpty) {
      fornecedores = await notifier.getFornecedoresByNome(query);
    }
    notifyListeners();
  }

  Future<void> deleteFornecedor(String? id) async {
    if (id == null) return;
    await notifier.delete(id);
    await loadFornecedores(); // recarrega lista
  }
}
