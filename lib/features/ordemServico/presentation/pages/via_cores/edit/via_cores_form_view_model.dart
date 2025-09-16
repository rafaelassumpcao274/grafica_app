import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/via_cores.dart';
import '../../../providers/via_cores_provider.dart';

final viaCoresViewModelProvider = ChangeNotifierProvider<ViaCoresFormViewModel>((ref) {
  final notifier = ref.watch(viacoresProvider.notifier); // Seu notifier do ViaCores
  return ViaCoresFormViewModel(notifier);
});


class ViaCoresFormViewModel extends ChangeNotifier {
  final ViaCoresNotifier notifier;
  final TextEditingController descricao = TextEditingController();
  String? errorMessage;

  ViaCoresFormViewModel(this.notifier);



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
}

