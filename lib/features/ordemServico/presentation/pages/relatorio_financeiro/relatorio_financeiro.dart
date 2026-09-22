import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/ordem_servico_financeiro_resumo_dto.dart';
import '../../core/theme.dart';
import '../../providers/relatorio_ordens_financeiro_provider.dart';
import 'relatorio_filtros_bottom_sheet.dart';

class RelatorioScreen extends ConsumerWidget {
  const RelatorioScreen({super.key});

  Future<void> _selecionarPeriodo(BuildContext context, WidgetRef ref, DateTimeRange atual) async {
    final hoje = DateTime.now();
    final novo = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(hoje.year + 1, 12, 31),
      initialDateRange: atual,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppColors.primaryBlue,
                ),
          ),
          child: child!,
        );
      },
    );
    if (novo != null) {
      final start = DateTime(novo.start.year, novo.start.month, novo.start.day);
      final end = DateTime(
          novo.end.year, novo.end.month, novo.end.day, 23, 59, 59, 999);
      ref.read(relatorioFiltroProvider.notifier).update(
            (f) => f.copyWith(periodo: DateTimeRange(start: start, end: end)),
          );
    }
  }

  Future<void> _abrirFiltros(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const RelatorioFiltrosBottomSheet(),
    );
  }

  _Totais _calcularTotais(List<OrdemServicoFinanceiroResumoDto> ordens) {
    double contratado = 0;
    double faturado = 0;
    double recebido = 0;
    for (final o in ordens) {
      contratado += o.contratado;
      faturado += o.faturado;
      recebido += o.recebido;
    }
    return _Totais(contratado: contratado, faturado: faturado, recebido: recebido);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtro = ref.watch(relatorioFiltroProvider);
    final resumoAsync = ref.watch(relatorioOrdensFinanceiroProvider);
    final semOsAsync = ref.watch(relatorioFaturamentoSemOSProvider);
    final currency = NumberFormat.simpleCurrency(locale: 'pt_BR');
    final dateFmt = DateFormat('dd/MM/yyyy');

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: Column(
          children: [
            _buildPeriodoSelector(context, ref, filtro, dateFmt),
            _buildFiltrosAtivos(context, ref, filtro),
            Expanded(
              child: resumoAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Erro ao carregar relatório: $error')),
                data: (ordens) {
                  final totais = _calcularTotais(ordens);
                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: Column(
                      children: [
                        _buildResumoCards(totais, currency),
                        const SizedBox(height: 24),
                        _buildListaOrdens(context, ref, ordens, currency, dateFmt),
                        semOsAsync.maybeWhen(
                          data: (semOs) => semOs.quantidade > 0
                              ? _buildRodapeSemOS(semOs, currency)
                              : const SizedBox.shrink(),
                          orElse: () => const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodoSelector(
      BuildContext context, WidgetRef ref, RelatorioFiltro filtro, DateFormat dateFmt) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.date_range, color: AppColors.textGray.withValues(alpha: 0.9)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${dateFmt.format(filtro.periodo.start)} — ${dateFmt.format(filtro.periodo.end)}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          TextButton(
            onPressed: () => _selecionarPeriodo(context, ref, filtro.periodo),
            child: const Text('Alterar'),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltrosAtivos(BuildContext context, WidgetRef ref, RelatorioFiltro filtro) {
    final chips = <Widget>[];

    if (filtro.ordemServicoId != null) {
      chips.add(Chip(
        label: Text('OS #${filtro.ordemServicoId}'),
        onDeleted: () => ref
            .read(relatorioFiltroProvider.notifier)
            .update((f) => f.copyWith(limparOrdemServico: true)),
      ));
    }
    if (filtro.faturaId != null) {
      chips.add(Chip(
        label: Text('Fatura #${filtro.faturaId}'),
        onDeleted: () => ref
            .read(relatorioFiltroProvider.notifier)
            .update((f) => f.copyWith(limparFatura: true)),
      ));
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ActionChip(
            avatar: const Icon(Icons.filter_list, size: 18),
            label: const Text('Filtros'),
            onPressed: () => _abrirFiltros(context),
          ),
          ...chips,
        ],
      ),
    );
  }

  Widget _buildResumoCards(_Totais totais, NumberFormat currency) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _ResumoCard(
                title: 'Contratado',
                value: currency.format(totais.contratado),
                icon: Icons.description_outlined,
                gradient: const LinearGradient(
                  colors: [AppColors.primaryBlue, AppColors.accentPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _ResumoCard(
                title: 'Faturado',
                value: currency.format(totais.faturado),
                icon: Icons.receipt_long_outlined,
                gradient: const LinearGradient(
                  colors: [Color(0xFFFBBF77), Color(0xFFF59E0B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _ResumoCard(
                title: 'Recebido',
                value: currency.format(totais.recebido),
                icon: Icons.attach_money,
                gradient: const LinearGradient(
                  colors: [Color(0xFF34D399), Color(0xFF10B981)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _ResumoCard(
                title: 'Saldo a receber',
                value: currency.format(totais.faturado - totais.recebido),
                icon: Icons.hourglass_bottom,
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF9AA2), Color(0xFFFF6B6B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildListaOrdens(BuildContext context, WidgetRef ref, List<OrdemServicoFinanceiroResumoDto> ordens,
      NumberFormat currency, DateFormat dateFmt) {
    if (ordens.isEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text('Nenhuma ordem no período/filtro selecionado',
              style: Theme.of(context).textTheme.bodyMedium),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Ordens no período (${ordens.length})',
              style: Theme.of(context).textTheme.titleLarge),
        ),
        const SizedBox(height: 12),
        ...ordens.map((o) => _OrdemTile(
              resumo: o,
              currency: currency,
              dateFmt: dateFmt,
              onTap: () => ref
                  .read(relatorioFiltroProvider.notifier)
                  .update((f) => f.copyWith(ordemServicoId: o.ordemServicoId)),
            )),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildRodapeSemOS(
      ({double faturado, double recebido, int quantidade}) semOs, NumberFormat currency) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.mediumGray.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: AppColors.textGray, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Faturas sem OS vinculada: ${semOs.quantidade} • '
              'Faturado ${currency.format(semOs.faturado)} • '
              'Recebido ${currency.format(semOs.recebido)}',
              style: const TextStyle(color: AppColors.textGray, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResumoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Gradient gradient;

  const _ResumoCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
        gradient: gradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 12),
          Text(title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white)),
          const SizedBox(height: 4),
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: Colors.white, fontSize: 18)),
        ],
      ),
    );
  }
}

class _OrdemTile extends StatelessWidget {
  final OrdemServicoFinanceiroResumoDto resumo;
  final NumberFormat currency;
  final DateFormat dateFmt;
  final VoidCallback onTap;

  const _OrdemTile({
    required this.resumo,
    required this.currency,
    required this.dateFmt,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final saldo = resumo.saldo;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.description_outlined, color: AppColors.primaryBlue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${resumo.ordemServicoId} • ${resumo.clienteNome ?? "Cliente não informado"}',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 4),
                  Text(
                    resumo.ordemServicoCreatedAt != null
                        ? dateFmt.format(resumo.ordemServicoCreatedAt!)
                        : '—',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Text('${resumo.quantidadeFaturas} fatura(s)',
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Contratado ${currency.format(resumo.contratado)}',
                    style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 4),
                Text('Faturado ${currency.format(resumo.faturado)}',
                    style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 4),
                Text('Recebido ${currency.format(resumo.recebido)}',
                    style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 6),
                Text(
                  'Saldo ${currency.format(saldo)}',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: saldo <= 0 ? AppColors.success : AppColors.warning,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Totais {
  final double contratado;
  final double faturado;
  final double recebido;

  const _Totais({
    required this.contratado,
    required this.faturado,
    required this.recebido,
  });
}
