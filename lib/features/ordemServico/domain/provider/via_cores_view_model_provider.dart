import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/via_cores_dto.dart';

final viaCoresViewModelProvider =
ChangeNotifierProvider<ViaCoresViewModel>((ref) {
  return ViaCoresViewModel();
});