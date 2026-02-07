import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/ordemservico_provider.dart';

import '../../../domain/entities/ordemservico.dart';
import '../../core/theme.dart';

class RelatorioScreen extends ConsumerStatefulWidget {
  const RelatorioScreen({super.key});

  @override
  ConsumerState<RelatorioScreen> createState() => _RelatorioScreenState();
}

class _RelatorioScreenState extends ConsumerState<RelatorioScreen> {
  late DateTimeRange _range;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    _range = DateTimeRange(start: startOfMonth, end: now);
  }

  @override
  Widget build(BuildContext context) {
    final _service = ref.read(ordemServicoProvider);
    final ordens = _filtrarOrdensPorPeriodo(_service.value!, _range);
    final totais = _calcularTotais(ordens);
    final currency = NumberFormat.simpleCurrency(locale: 'pt_BR');
    final dateFmt = DateFormat('dd/MM/yyyy');

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: Column(
          children: [
            _buildPeriodoSelector(dateFmt),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Column(
                  children: [
                    _ResumoCard(
                      title: 'Custo',
                      value: currency.format(totais.custoTotal),
                      icon: Icons.trending_down,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF9AA2), Color(0xFFFF6B6B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _ResumoCard(
                      title: 'Receita',
                      value: currency.format(totais.receitaTotal),
                      icon: Icons.trending_up,
                      gradient: const LinearGradient(
                        colors: [AppColors.primaryBlue, AppColors.accentPurple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _ResumoCard(
                      title: 'Lucro',
                      value: currency.format(totais.lucroTotal),
                      subtitle: totais.receitaTotal > 0
                          ? '${(totais.lucroTotal / totais.receitaTotal * 100).toStringAsFixed(1)}% margem'
                          : null,
                      icon: Icons.attach_money,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF34D399), Color(0xFF10B981)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildListaOrdens(ordens, currency, dateFmt),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 16),
              Text('Relatório Financeiro',
                  style: Theme.of(context).textTheme.displaySmall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodoSelector(DateFormat dateFmt) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 16),
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
          Icon(Icons.date_range,
              color: AppColors.textGray.withValues(alpha: 0.9)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${dateFmt.format(_range.start)} — ${dateFmt.format(_range.end)}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          TextButton(
            onPressed: _selecionarPeriodo,
            child: const Text('Alterar'),
          ),
        ],
      ),
    );
  }

  Future<void> _selecionarPeriodo() async {
    final hoje = DateTime.now();
    final novo = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(hoje.year + 1, 12, 31),
      initialDateRange: _range,
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
      setState(() => _range = DateTimeRange(
          start: _atStartOfDay(novo.start), end: _atEndOfDay(novo.end)));
    }
  }

  List<OrdemServico> _filtrarOrdensPorPeriodo(
      List<OrdemServico> ordens, DateTimeRange range) {
    final start = _atStartOfDay(range.start);
    final end = _atEndOfDay(range.end);
    return ordens.where((o) {
      final d = o.createdAt;
      final afterStart = !d!.isBefore(start); // >= start
      final beforeEnd = !d!.isAfter(end); // <= end
      return afterStart && beforeEnd;
    }).toList();
  }

  _Totais _calcularTotais(List<OrdemServico> ordens) {
    double custo = 0;
    double receita = 0;
    for (final o in ordens) {
      custo += (o.valorCusto ?? 0);
      receita += (o.valorTotal ?? 0);
    }
    return _Totais(
      custoTotal: custo,
      receitaTotal: receita,
      lucroTotal: receita - custo,
    );
  }

  DateTime _atStartOfDay(DateTime d) => DateTime(d.year, d.month, d.day);

  DateTime _atEndOfDay(DateTime d) =>
      DateTime(d.year, d.month, d.day, 23, 59, 59, 999);

  Widget _buildListaOrdens(
      List<OrdemServico> ordens, NumberFormat currency, DateFormat dateFmt) {
    if (ordens.isEmpty) {
      return Container(
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
          child: Text('Nenhuma ordem no período selecionado',
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
        ...ordens
            .map((o) =>
                _OrdemTile(ordem: o, currency: currency, dateFmt: dateFmt))
            .toList(),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _ResumoCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Gradient gradient;

  const _ResumoCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.gradient,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: Colors.white)),
                const SizedBox(height: 6),
                Text(value,
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: Colors.white, fontSize: 24)),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(subtitle!,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: Colors.white)),
                ]
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OrdemTile extends StatelessWidget {
  final OrdemServico ordem;
  final NumberFormat currency;
  final DateFormat dateFmt;

  const _OrdemTile(
      {required this.ordem, required this.currency, required this.dateFmt});

  @override
  Widget build(BuildContext context) {
    final custo = currency.format(ordem.valorCusto ?? 0);
    final total = currency.format(ordem.valorTotal ?? 0);
    final lucro = (ordem.valorTotal ?? 0) - (ordem.valorCusto ?? 0);
    final lucroStr = currency.format(lucro);

    return Container(
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
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.description_outlined,
                color: AppColors.primaryBlue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${ordem.id} • ${ordem.clientes!.nomeEmpresa}',
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(dateFmt.format(ordem.createdAt!),
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Custo $custo',
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 4),
              Text('Receita $total',
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 6),
              Text(
                'Lucro $lucroStr',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: lucro >= 0 ? AppColors.success : AppColors.error,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _Totais {
  final double custoTotal;
  final double receitaTotal;
  final double lucroTotal;

  const _Totais(
      {required this.custoTotal,
      required this.receitaTotal,
      required this.lucroTotal});
}
