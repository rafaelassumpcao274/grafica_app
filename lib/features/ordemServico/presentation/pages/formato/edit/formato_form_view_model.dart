import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/formato.dart';
import '../../../providers/formato_provider.dart';

final formatoViewModelProvider =
    ChangeNotifierProvider<FormatoFormViewModel>((ref) {
  final notifier =
      ref.watch(formatoProvider.notifier); // Seu notifier do Formato
  return FormatoFormViewModel(notifier);
});

class FormatoFormViewModel extends ChangeNotifier {
  final FormatoNotifier notifier;
  final TextEditingController descricao = TextEditingController();
  String? errorMessage;

  FormatoFormViewModel(this.notifier);

  bool validar() {
    if (descricao.text.isEmpty) {
      errorMessage = 'Informe o nome da via';
      notifyListeners();
      return false;
    }
    errorMessage = null;
    return true;
  }

  Formato getFormato({String? id}) {
    return Formato(id: id, descricao: descricao.text);
  }

  void clear() {
    descricao.clear();
    errorMessage = null;
    notifyListeners();
  }
}
