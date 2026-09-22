import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/parcela_dto.dart';
import '../../domain/parcela_resumo_dto.dart';
import '../../domain/provider/providers.dart';
import '../../domain/repositories/financeiro_repository.dart';

class ParcelaNotifier extends AsyncNotifier<List<ParcelaDto>> {
  late FinanceiroRepository repository;

  @override
  Future<List<ParcelaDto>> build() async {
    repository = await ref.watch(financeiroRepositoryProvider.future);
    return await repository.obterParcelasVencidas(DateTime.now());
  }

  Future<void> loadVencidas() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await repository.obterParcelasVencidas(DateTime.now());
    });
  }

  Future<void> registrarRecebimento({
    required int parcelaId,
    required double valor,
    required DateTime dataPagamento,
    String? formaPagamento,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repository.registrarRecebimento(
        parcelaId: parcelaId,
        valor: valor,
        dataPagamento: dataPagamento,
        formaPagamento: formaPagamento,
      );
      return await repository.obterParcelasVencidas(DateTime.now());
    });
  }
}

final parcelaProvider =
    AsyncNotifierProvider<ParcelaNotifier, List<ParcelaDto>>(
        ParcelaNotifier.new);

/// Parcelas de uma fatura específica, com total recebido e saldo por parcela
final parcelasPorFaturaProvider =
    FutureProvider.autoDispose.family<List<ParcelaResumoDto>, int>(
        (ref, faturaId) async {
  final repository = await ref.watch(financeiroRepositoryProvider.future);
  return repository.obterParcelasPorFatura(faturaId);
});
