import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/ordem_servico_financeiro_resumo_dto.dart';
import '../../domain/provider/providers.dart';

class RelatorioFiltro {
  final DateTimeRange periodo;
  final int? ordemServicoId;
  final int? faturaId;

  const RelatorioFiltro({
    required this.periodo,
    this.ordemServicoId,
    this.faturaId,
  });

  factory RelatorioFiltro.mesAtual() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    return RelatorioFiltro(periodo: DateTimeRange(start: startOfMonth, end: now));
  }

  RelatorioFiltro copyWith({
    DateTimeRange? periodo,
    int? ordemServicoId,
    int? faturaId,
    bool limparOrdemServico = false,
    bool limparFatura = false,
  }) {
    return RelatorioFiltro(
      periodo: periodo ?? this.periodo,
      ordemServicoId: limparOrdemServico ? null : (ordemServicoId ?? this.ordemServicoId),
      faturaId: limparFatura ? null : (faturaId ?? this.faturaId),
    );
  }
}

final relatorioFiltroProvider = StateProvider<RelatorioFiltro>(
  (ref) => RelatorioFiltro.mesAtual(),
);

final relatorioOrdensFinanceiroProvider =
    FutureProvider.autoDispose<List<OrdemServicoFinanceiroResumoDto>>((ref) async {
  final filtro = ref.watch(relatorioFiltroProvider);
  final repository = await ref.watch(financeiroRepositoryProvider.future);
  return repository.obterResumoFinanceiroPorOrdemServico(
    periodoInicio: filtro.periodo.start,
    periodoFim: filtro.periodo.end,
    ordemServicoId: filtro.ordemServicoId,
    faturaId: filtro.faturaId,
  );
});

final relatorioFaturamentoSemOSProvider =
    FutureProvider.autoDispose<({double faturado, double recebido, int quantidade})>((ref) async {
  final filtro = ref.watch(relatorioFiltroProvider);
  final repository = await ref.watch(financeiroRepositoryProvider.future);
  return repository.obterFaturamentoSemOrdemServico(
    periodoInicio: filtro.periodo.start,
    periodoFim: filtro.periodo.end,
  );
});
