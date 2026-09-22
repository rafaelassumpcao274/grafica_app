import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/repositories/financeiro_repository.dart'
    show kMaxParcelasFatura;
import '../../core/theme.dart';
import '../../widgets/components/custom_btn.dart';
import '../../widgets/components/custom_decimal_input.dart';
import '../../widgets/components/custom_text_input.dart';
import '../../widgets/ordem_servico/ordem_servico_bottom_sheet.dart';
import 'fatura_creation_view_model.dart';

class FaturaCreationPage extends ConsumerStatefulWidget {
  const FaturaCreationPage({super.key});

  @override
  ConsumerState<FaturaCreationPage> createState() => _FaturaCreationPageState();
}

class _FaturaCreationPageState extends ConsumerState<FaturaCreationPage> {
  final TextEditingController _osController = TextEditingController();
  final TextEditingController _valorTotalController = TextEditingController();
  final TextEditingController _dataFaturaController = TextEditingController();
  final TextEditingController _dataVencimentoController =
      TextEditingController();
  final TextEditingController _dataPrimeiraParcelaController =
      TextEditingController();

  @override
  void dispose() {
    _osController.dispose();
    _valorTotalController.dispose();
    _dataFaturaController.dispose();
    _dataVencimentoController.dispose();
    _dataPrimeiraParcelaController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(faturaViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      appBar: AppBar(title: const Text('Criar Fatura')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Ordem de Serviço'),
            const SizedBox(height: 16),
            OrdemServicoBottomSheetAutocomplete(
              controller: _osController,
              onSelected: (os) {
                viewModel.selectOrdenServico(os);
                _valorTotalController.text = os.valorTotal.toStringAsFixed(2);
              },
            ),
            const SizedBox(height: 32),

            _buildSectionTitle('Modo de Parcelamento'),
            const SizedBox(height: 16),
            _buildModeToggle(viewModel),
            const SizedBox(height: 24),

            if (viewModel.parcelMode == ParcelMode.byDate)
              _buildDateModeFields(viewModel)
            else
              _buildInstallmentsModeFields(viewModel),

            const SizedBox(height: 24),
            _buildSectionTitle('Valor Total'),
            const SizedBox(height: 16),
            CustomDecimalInput(
              controller: _valorTotalController,
              hintText: 'Valor Total',
              icon: Icons.attach_money,
              onChanged: (value) {
                viewModel.setValorTotal(double.tryParse(value) ?? 0.0);
              },
            ),

            if (viewModel.previewParcelas.isNotEmpty) ...[
              const SizedBox(height: 32),
              _buildSectionTitle('Preview das Parcelas'),
              const SizedBox(height: 16),
              _buildParcelasPreview(viewModel),
            ],

            if (viewModel.errorMessage != null) ...[
              const SizedBox(height: 24),
              _buildErrorBanner(viewModel.errorMessage!),
            ],

            const SizedBox(height: 32),
            CustomBtn(
              text: 'Criar Fatura',
              enabled: !viewModel.isLoading,
              onTap: () async {
                if (viewModel.parcelMode == ParcelMode.byDate) {
                  await viewModel.createInvoiceByDate(
                    ordemServicoId: viewModel.selectedOS?.id,
                  );
                } else {
                  await viewModel.createInvoiceByInstallments(
                    ordemServicoId: viewModel.selectedOS?.id,
                  );
                }

                if (context.mounted && viewModel.errorMessage == null) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Fatura criada com sucesso!')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.textDark,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildModeToggle(FaturaViewModel viewModel) {
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
      child: Row(
        children: [
          Expanded(
            child: _buildModeOption('Por Data', ParcelMode.byDate, viewModel),
          ),
          Container(width: 1, height: 36, color: AppColors.mediumGray),
          Expanded(
            child: _buildModeOption(
                'Por Parcelas', ParcelMode.byInstallments, viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildModeOption(
      String label, ParcelMode mode, FaturaViewModel viewModel) {
    final selected = viewModel.parcelMode == mode;
    return GestureDetector(
      onTap: () => viewModel.toggleParcelMode(mode),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryBlue.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? AppColors.primaryBlue : AppColors.textGray,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateModeFields(FaturaViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Data da Fatura'),
        const SizedBox(height: 16),
        CustomTextInput(
          controller: _dataFaturaController,
          hintText: 'Selecione a data',
          icon: Icons.calendar_today,
          readOnly: true,
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: viewModel.dataFatura ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );
            if (date != null) {
              viewModel.setDataFatura(date);
              _dataFaturaController.text = _formatDate(date);
              if (viewModel.dataVencimento == null) {
                _dataVencimentoController.clear();
              }
            }
          },
        ),
        const SizedBox(height: 16),
        _buildSectionTitle('Data de Vencimento'),
        const SizedBox(height: 16),
        CustomTextInput(
          controller: _dataVencimentoController,
          hintText: 'Selecione a data',
          icon: Icons.calendar_today,
          readOnly: true,
          onTap: () async {
            if (viewModel.dataFatura == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Selecione primeiro a data da fatura')),
              );
              return;
            }

            final date = await showDatePicker(
              context: context,
              initialDate: viewModel.dataVencimento ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );
            if (date == null) return;

            if (date.isAfter(viewModel.dataFatura!)) {
              viewModel.calculateByDate(viewModel.dataFatura!, date);
              _dataVencimentoController.text = _formatDate(date);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('Data de vencimento deve ser após a data da fatura'),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildInstallmentsModeFields(FaturaViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Quantidade de Parcelas'),
        const SizedBox(height: 16),
        _buildQuantidadeParcelasDropdown(viewModel),
        const SizedBox(height: 16),
        _buildSectionTitle('Data da Primeira Parcela'),
        const SizedBox(height: 16),
        CustomTextInput(
          controller: _dataPrimeiraParcelaController,
          hintText: 'Selecione a data',
          icon: Icons.calendar_today,
          readOnly: true,
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: viewModel.dataPrimeiraParcela ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );
            if (date != null) {
              viewModel.calculateByInstallments(
                  viewModel.quantidadeParcelas, date);
              _dataPrimeiraParcelaController.text = _formatDate(date);
            }
          },
        ),
      ],
    );
  }

  Widget _buildQuantidadeParcelasDropdown(FaturaViewModel viewModel) {
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
      child: DropdownButtonFormField<int>(
        value: viewModel.quantidadeParcelas,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.repeat),
          labelText: 'Quantidade de Parcelas',
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        items: List.generate(kMaxParcelasFatura, (index) => index + 1)
            .map((quantidade) => DropdownMenuItem(
                  value: quantidade,
                  child: Text(
                    '$quantidade ${quantidade == 1 ? 'parcela' : 'parcelas'}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ))
            .toList(),
        onChanged: (quantidade) {
          if (quantidade != null) {
            viewModel.setQuantidadeParcelas(quantidade);
          }
        },
        dropdownColor: AppColors.white,
        icon: Icon(Icons.keyboard_arrow_down_rounded,
            color: AppColors.textGray),
        isExpanded: true,
      ),
    );
  }

  Widget _buildParcelasPreview(FaturaViewModel viewModel) {
    return Column(
      children: viewModel.previewParcelas.map((parcela) {
        return Card(
          color: AppColors.white,
          margin: const EdgeInsets.only(bottom: 8),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Parcela ${parcela.numero}',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Venc: ${_formatDate(parcela.vencimento)}',
                      style: TextStyle(color: AppColors.textGray, fontSize: 12),
                    ),
                  ],
                ),
                Text(
                  'R\$ ${parcela.valor.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: AppColors.success),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildErrorBanner(String message) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.08),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: AppColors.error, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(message, style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
