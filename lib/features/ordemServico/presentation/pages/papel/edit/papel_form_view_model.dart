

import 'package:flutter/cupertino.dart';

import '../../../../domain/entities/papel.dart';
import '../../../providers/papel_provider.dart';
import '../../../widgets/number_editing_controller.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final papelFormViewModelProvider = ChangeNotifierProvider<PapelFormViewModel>((ref) {
  final notifier = ref.read(papelProvider.notifier);
  return PapelFormViewModel(notifier);
});


class PapelFormViewModel extends ChangeNotifier {
  final PapelNotifier notifier;

  final TextEditingController descricao = TextEditingController();
  final NumberEditingController<int> quantidade = NumberEditingController<int>();

  String? errorMessage;
  bool isLoading = false;

  PapelFormViewModel(this.notifier);

  Future<void> loadPapel(String id) async {
    isLoading = true;
    notifyListeners();

    final papel = await notifier.getById(id);
    if (papel != null) {
      descricao.text = papel.descricao ?? '';
      quantidade.text = papel.quantidadePapel.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Papel getPapel({String? id}) {
    return Papel(
      id: id,
      descricao: descricao.text,
      quantidadePapel: quantidade.number ?? 0,
    );
  }

  bool validar() {
    if (descricao.text.isEmpty) {
      errorMessage = 'Informe o nome do Papel';
      notifyListeners();
      return false;
    }
    errorMessage = null;
    return true;
  }

  void clear() {
    descricao.clear();
    quantidade.clear();
    errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    descricao.dispose();
    quantidade.dispose();
    super.dispose();
  }
}
