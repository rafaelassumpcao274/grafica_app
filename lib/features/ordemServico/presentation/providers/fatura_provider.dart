import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/fatura_resumo_dto.dart';
import '../../domain/provider/providers.dart';
import '../../domain/repositories/financeiro_repository.dart';

class FaturaNotifier extends AsyncNotifier<List<FaturaResumoDto>> {
  late FinanceiroRepository repository;

  @override
  Future<List<FaturaResumoDto>> build() async {
    repository = await ref.watch(financeiroRepositoryProvider.future);
    return await repository.obterFaturasComTotais();
  }

  Future<void> loadFaturas() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await repository.obterFaturasComTotais();
    });
  }

  Future<void> criarFatura({
    int? ordemServicoId,
    String? descricao,
    required double valorTotal,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repository.criarFatura(
        ordemServicoId: ordemServicoId,
        descricao: descricao,
        valorTotal: valorTotal,
      );
      return await repository.obterFaturasComTotais();
    });
  }
}

final faturaProvider =
    AsyncNotifierProvider<FaturaNotifier, List<FaturaResumoDto>>(
        FaturaNotifier.new);
