import 'package:flutter/cupertino.dart';

import '../../../../domain/entities/via_cores.dart';
import '../../../providers/via_cores_provider.dart';

class ViaCoresListViewModel extends ChangeNotifier {
  final ViaCoresNotifier notifier; // seu provider original
  List<ViaCores> vias = [];
  List<ViaCores> filtered = [];

  ViaCoresListViewModel(this.notifier) {
    loadVias();
  }

  Future<void> loadVias() async {
    vias = await notifier.build(); // busca todas as vias
    filtered = List.from(vias);
    notifyListeners();
  }

  void filter(String query) {
    filtered = vias
        .where((v) => v.descricao.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Future<void> delete(String id) async {
    await notifier.delete(id);
    await loadVias();
  }
}
