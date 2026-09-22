import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/via_cores.dart';
import '../../../providers/via_cores_provider.dart';

final viaCoresViewModelProvider = ChangeNotifierProvider.autoDispose<ViaCoresFormViewModel>((ref) {
  final notifier = ref.watch(viacoresProvider.notifier); // Seu notifier do ViaCores
  return ViaCoresFormViewModel(notifier);
});


class ViaCoresFormViewModel extends ChangeNotifier {
  final ViaCoresNotifier notifier;
  final TextEditingController descricao = TextEditingController();
  String? errorMessage;

  ViaCoresFormViewModel(this.notifier);

  /// Carrega uma via de cores existente para edição
  Future<void> loadViaCores(String id) async {
    final via = await notifier.getById(id);
    if (via != null) {
      descricao.text = via.descricao;
      notifyListeners();
    }
  }

  bool validar() {
    if (descricao.text.isEmpty) {
      errorMessage = 'Informe o nome da via';
      notifyListeners();
      return false;
    }
    errorMessage = null;
    return true;
  }

  ViaCores getViaCores({String? id}) {
    return ViaCores(id: id, descricao: descricao.text);
  }

  void clear() {
    descricao.clear();
    errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    descricao.dispose();
    super.dispose();
  }
}

