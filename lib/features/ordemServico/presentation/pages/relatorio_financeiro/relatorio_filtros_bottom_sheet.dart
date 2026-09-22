import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/ordemservico.dart';
import '../../../domain/fatura_resumo_dto.dart';
import '../../core/theme.dart';
import '../../providers/relatorio_ordens_financeiro_provider.dart';
import '../../widgets/fatura/fatura_bottom_sheet_autocomplete.dart';
import '../../widgets/ordem_servico/ordem_servico_bottom_sheet.dart';

class RelatorioFiltrosBottomSheet extends ConsumerStatefulWidget {
  const RelatorioFiltrosBottomSheet({super.key});

  @override
  ConsumerState<RelatorioFiltrosBottomSheet> createState() =>
      _RelatorioFiltrosBottomSheetState();
}

class _RelatorioFiltrosBottomSheetState
    extends ConsumerState<RelatorioFiltrosBottomSheet> {
  OrdemServico? _ordemSelecionada;
  FaturaResumoDto? _faturaSelecionada;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filtrar relatório', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            OrdemServicoBottomSheetAutocomplete(
              hintText: 'Filtrar por Ordem de Serviço',
              onSelected: (os) => setState(() => _ordemSelecionada = os),
            ),
            const SizedBox(height: 12),
            FaturaBottomSheetAutocomplete(
              hintText: 'Filtrar por Fatura',
              onSelected: (fatura) => setState(() => _faturaSelecionada = fatura),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      ref.read(relatorioFiltroProvider.notifier).update(
                            (f) => f.copyWith(
                              limparOrdemServico: true,
                              limparFatura: true,
                            ),
                          );
                      Navigator.pop(context);
                    },
                    child: const Text('Limpar filtros'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      ref.read(relatorioFiltroProvider.notifier).update(
                            (f) => f.copyWith(
                              ordemServicoId: _ordemSelecionada?.id,
                              faturaId: _faturaSelecionada?.id,
                            ),
                          );
                      Navigator.pop(context);
                    },
                    child: const Text('Aplicar'),
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
