import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/parcela_resumo_dto.dart';
import '../../../domain/provider/providers.dart';
import '../../core/theme.dart';
import '../../providers/fatura_provider.dart';
import '../../providers/parcela_provider.dart';
import '../components/custom_btn.dart';
import '../components/custom_decimal_input.dart';
import '../components/custom_text_input.dart';

class FaturaParcelasBottomSheet extends ConsumerWidget {
  final int faturaId;
  final String faturaLabel;

  const FaturaParcelasBottomSheet({
    super.key,
    required this.faturaId,
    required this.faturaLabel,
  });

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parcelasAsync = ref.watch(parcelasPorFaturaProvider(faturaId));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    faturaLabel,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline, color: AppColors.error),
                  tooltip: 'Excluir fatura',
                  onPressed: () => _confirmarExclusao(context, ref),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: parcelasAsync.when(
                data: (parcelas) {
                  if (parcelas.isEmpty) {
                    return const Center(child: Text('Nenhuma parcela'));
                  }

                  final emAberto =
                      parcelas.where((p) => p.status != 'PAGA').toList();

                  return ListView.builder(
                    itemCount: parcelas.length,
                    itemBuilder: (context, index) {
                      final parcela = parcelas[index];
                      final paga = parcela.status == 'PAGA';

                      return Card(
                        color: AppColors.white,
                        margin: const EdgeInsets.only(bottom: 8),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Text(
                            'Parcela ${parcela.numero} — R\$ ${parcela.valor.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textDark),
                          ),
                          subtitle: Text(
                            'Venc: ${_formatDate(parcela.vencimento)} • Saldo: R\$ ${parcela.saldo.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: AppColors.textGray, fontSize: 12),
                          ),
                          trailing: paga
                              ? Icon(Icons.check_circle,
                                  color: AppColors.success)
                              : TextButton(
                                  onPressed: () => _abrirRegistroRecebimento(
                                      context, ref, parcela, emAberto),
                                  child: const Text('Registrar'),
                                ),
                        ),
                      );
                    },
                  );
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    Center(child: Text('Erro: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmarExclusao(BuildContext context, WidgetRef ref) async {
    final confirmou = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir fatura'),
        content: Text(
          'Tem certeza que deseja excluir "$faturaLabel"? Todas as parcelas e recebimentos associados também serão excluídos. Essa ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text('Excluir', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );

    if (confirmou != true) return;

    try {
      final repository = await ref.read(financeiroRepositoryProvider.future);
      await repository.deletarFatura(faturaId);

      ref.invalidate(faturaProvider);
      ref.invalidate(parcelaProvider);

      if (context.mounted) Navigator.pop(context);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao excluir fatura: $e')),
        );
      }
    }
  }

  Future<void> _abrirRegistroRecebimento(
    BuildContext context,
    WidgetRef ref,
    ParcelaResumoDto parcela,
    List<ParcelaResumoDto> emAberto,
  ) async {
    final outrasEmAberto =
        emAberto.where((p) => p.id != parcela.id).toList();

    final registrado = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _RegistrarRecebimentoSheet(
        parcela: parcela,
        outrasEmAberto: outrasEmAberto,
      ),
    );

    if (registrado == true) {
      ref.invalidate(parcelasPorFaturaProvider(faturaId));
      ref.invalidate(faturaProvider);
      ref.invalidate(parcelaProvider);
    }
  }
}

class _RegistrarRecebimentoSheet extends ConsumerStatefulWidget {
  final ParcelaResumoDto parcela;
  final List<ParcelaResumoDto> outrasEmAberto;

  const _RegistrarRecebimentoSheet({
    required this.parcela,
    required this.outrasEmAberto,
  });

  @override
  ConsumerState<_RegistrarRecebimentoSheet> createState() =>
      _RegistrarRecebimentoSheetState();
}

class _RegistrarRecebimentoSheetState
    extends ConsumerState<_RegistrarRecebimentoSheet> {
  static const _formasPagamento = ['PIX', 'BOLETO', 'DINHEIRO'];

  late final TextEditingController _valorController;
  late final TextEditingController _dataPagamentoController;
  DateTime _dataPagamento = DateTime.now();
  String _formaPagamento = _formasPagamento.first;
  bool _aplicarATodas = false;
  bool _salvando = false;

  bool get _temOutrasEmAberto => widget.outrasEmAberto.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _valorController =
        TextEditingController(text: widget.parcela.saldo.toStringAsFixed(2));
    _dataPagamentoController =
        TextEditingController(text: _formatDate(_dataPagamento));
  }

  @override
  void dispose() {
    _valorController.dispose();
    _dataPagamentoController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

  double get _totalATodas =>
      widget.outrasEmAberto.fold(widget.parcela.saldo, (a, p) => a + p.saldo);

  Future<void> _salvar() async {
    final valorParcelaAtual = double.tryParse(_valorController.text) ?? 0.0;

    if (!_aplicarATodas && valorParcelaAtual <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe um valor válido')),
      );
      return;
    }

    setState(() => _salvando = true);

    try {
      final repository = await ref.read(financeiroRepositoryProvider.future);

      if (_aplicarATodas) {
        await repository.registrarRecebimento(
          parcelaId: widget.parcela.id,
          valor: widget.parcela.saldo,
          dataPagamento: _dataPagamento,
          formaPagamento: _formaPagamento,
        );
        for (final p in widget.outrasEmAberto) {
          await repository.registrarRecebimento(
            parcelaId: p.id,
            valor: p.saldo,
            dataPagamento: _dataPagamento,
            formaPagamento: _formaPagamento,
          );
        }
      } else {
        await repository.registrarRecebimento(
          parcelaId: widget.parcela.id,
          valor: valorParcelaAtual,
          dataPagamento: _dataPagamento,
          formaPagamento: _formaPagamento,
        );
      }

      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao registrar recebimento: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _salvando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Registrar Recebimento — Parcela ${widget.parcela.numero}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 16),

            if (_temOutrasEmAberto) ...[
              _buildEscopoSelector(),
              const SizedBox(height: 16),
            ],

            if (!_aplicarATodas) ...[
              CustomDecimalInput(
                controller: _valorController,
                hintText: 'Valor recebido',
                icon: Icons.attach_money,
              ),
              const SizedBox(height: 16),
            ] else ...[
              Text(
                'Será registrado o pagamento total de ${widget.outrasEmAberto.length + 1} parcelas, somando R\$ ${_totalATodas.toStringAsFixed(2)}.',
                style: TextStyle(color: AppColors.textGray, fontSize: 13),
              ),
              const SizedBox(height: 16),
            ],

            CustomTextInput(
              controller: _dataPagamentoController,
              hintText: 'Data do pagamento',
              icon: Icons.calendar_today,
              readOnly: true,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _dataPagamento,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (date != null) {
                  setState(() {
                    _dataPagamento = date;
                    _dataPagamentoController.text = _formatDate(date);
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            _buildFormaPagamentoSelector(),
            const SizedBox(height: 24),
            CustomBtn(
              text: 'Confirmar Recebimento',
              enabled: !_salvando,
              onTap: _salvar,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEscopoSelector() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mediumGray.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          RadioListTile<bool>(
            value: false,
            groupValue: _aplicarATodas,
            onChanged: (value) => setState(() => _aplicarATodas = value!),
            title: const Text('Apenas esta parcela'),
            dense: true,
          ),
          RadioListTile<bool>(
            value: true,
            groupValue: _aplicarATodas,
            onChanged: (value) => setState(() => _aplicarATodas = value!),
            title: Text(
                'Todas as parcelas em aberto (${widget.outrasEmAberto.length + 1})'),
            dense: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFormaPagamentoSelector() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mediumGray.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        initialValue: _formaPagamento,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.payments_outlined, color: AppColors.textGray),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        ),
        items: _formasPagamento
            .map((forma) => DropdownMenuItem(value: forma, child: Text(forma)))
            .toList(),
        onChanged: (value) {
          if (value != null) setState(() => _formaPagamento = value);
        },
      ),
    );
  }
}
