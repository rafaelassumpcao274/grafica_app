import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/papel.dart';
import '../../../providers/papel_provider.dart';

final papelListViewModelProvider =
ChangeNotifierProvider<PapelListViewModel>((ref) {
  final notifier = ref.read(papelProvider.notifier);
  return PapelListViewModel(notifier);
});


class PapelListViewModel extends ChangeNotifier {
  final PapelNotifier notifier;

  List<Papel> _papeis = [];
  bool isLoading = false;

  PapelListViewModel(this.notifier);

  List<Papel> get papeis => _papeis;

  Future<void> loadPapeis() async {
    isLoading = true;
    notifyListeners();

    _papeis = await notifier.build();
    isLoading = false;
    notifyListeners();
  }

  Future<void> deletePapel(String id) async {
    await notifier.delete(id);
    await loadPapeis();
  }

  List<Papel> filter(String query) {
    if (query.isEmpty) return _papeis;
    return _papeis
        .where((p) =>
        p.descricao.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
