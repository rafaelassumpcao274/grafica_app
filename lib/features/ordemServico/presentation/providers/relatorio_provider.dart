import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/relatorio_mensal_dto.dart';
import '../../domain/provider/providers.dart';
import '../../domain/repositories/financeiro_repository.dart';

class RelatorioNotifier extends AsyncNotifier<RelatorioMensalDto?> {
  late FinanceiroRepository repository;

  @override
  Future<RelatorioMensalDto?> build() async {
    repository = await ref.watch(financeiroRepositoryProvider.future);
    return null;
  }

  Future<void> loadMes(int year, int month) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await repository.resultadoMensal(year, month);
    });
  }
}

final relatorioProvider =
    AsyncNotifierProvider<RelatorioNotifier, RelatorioMensalDto?>(
        RelatorioNotifier.new);
