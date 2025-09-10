import 'package:flutter/cupertino.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/via_cores.dart';
import 'package:unilith_app/features/ordemServico/domain/vos/text.dart';

class ViaCoresViewModel extends ChangeNotifier {
  final descricao = TextEditingController();
  String? errorMessage;

  bool validar() {
    try {
      TextVO(descricao.text);
      errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  ViaCores getViaCores({String? id}) {
    return ViaCores(
      id: id,
      descricao: descricao.text,
    );
  }

  void disposeControllers() {
    descricao.dispose();
  }
}
