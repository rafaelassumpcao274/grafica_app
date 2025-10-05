import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/components/custom_obsevarcao_input.dart';

import '../../../../domain/entities/viaCoresOrdemServico.dart';
import '../../../core/theme.dart';
import '../../../widgets/cliente/cliente_autocomplete.dart';
import '../../../widgets/components/custom_decimal_input.dart';
import '../../../widgets/components/custom_integer_input.dart';
import '../../../widgets/components/custom_switch.dart';
import '../../../widgets/components/custom_text_input.dart';
import '../../../widgets/components/fornecedor_custo_autocomplete.dart';
import '../../../widgets/components/papel_autocomplete.dart';
import '../../../widgets/via_cores/chips_via_cores.dart';
import 'ordem_servico_form_view_model.dart';

class OrdemServicoForm extends ConsumerStatefulWidget {
  final int? ordemId;

  const OrdemServicoForm({super.key, this.ordemId});

  @override
  ConsumerState<OrdemServicoForm> createState() => _OrdemServicoFormPageState();
}

class _OrdemServicoFormPageState extends ConsumerState<OrdemServicoForm> {
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loaded) {
      Future.microtask(() async {
        final viewModel = ref.read(ordemServicoViewModelProvider);
        await viewModel.loadOrdem(widget.ordemId);
        if (mounted) {
          setState(() => _loaded = true);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(ordemServicoViewModelProvider);

    if (viewModel.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
        backgroundColor: AppColors.lightGray,
        body: SafeArea(
            child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Informações do Cliente'),
                      ClienteAutocomplete(
                        initialValue: viewModel.selectedCliente,
                        onSelected: (c) => viewModel.selectedCliente = c,
                      ),
                      SizedBox(height: 32),
                      _buildSectionTitle('Detalhes do Serviço'),
                      SizedBox(height: 16),
                      CustomTextInput(
                        controller: viewModel.materialController,
                        hintText: 'Material',
                        icon: Icons.inventory_2_outlined,
                      ),
                      const SizedBox(height: 16),
                      CustomTextInput(
                        controller: viewModel.tamanhoImagemController,
                        hintText: 'Tamanho',
                        icon: Icons.straighten_outlined,
                      ),
                      const SizedBox(height: 16),
                      PapelAutocomplete(
                        initialValue: viewModel.selectedPapel,
                        onSelected: (p) =>
                            setState(() => viewModel.selectedPapel = p),
                      ),
                      const SizedBox(height: 16),
                      ChipsInputVia(
                        initialItems:
                            viewModel.listVias.map((e) => e.viaCores!).toList(),
                        onChanged: (vias) {
                          viewModel.listVias = vias
                              .map((it) => ViaCoresOrdemServico(viaCores: it))
                              .toList();
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomIntegerInput(
                        controller: viewModel.quantidadeFolhaController,
                        hintText: 'Quantidade de Folhas',
                        icon: Icons.numbers,
                      ),
                      const SizedBox(height: 16),
                      CustomSwitch(
                        value: viewModel.possuiNumeracao,
                        onChanged: (v) {
                          setState(() {
                            viewModel.possuiNumeracao = v;
                          });
                        },
                        label: 'Possui numeração',
                      ),
                      if (viewModel.possuiNumeracao) ...[
                        const SizedBox(height: 16),
                        CustomIntegerInput(
                          controller: viewModel.numeracaoInicialController,
                          hintText: 'Numeração Inicial',
                          useThousandsSeparator: true,
                          icon: Icons.numbers,
                        ),
                        const SizedBox(height: 16),
                        CustomIntegerInput(
                          controller: viewModel.numeracaoFinalController,
                          hintText: 'Numeração Final',
                          useThousandsSeparator: true,
                          icon: Icons.numbers,
                        ),
                      ],
                      SizedBox(height: 32),
                      _buildSectionTitle('Fornecedor'),
                      const SizedBox(height: 16),
                      const FornecedorCustoAutocomplete(),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                              child: CustomDecimalInput(
                            controller: viewModel.valorCustoController,
                            hintText: 'Valor Custo',
                            enabled: false,
                                icon: Icons.attach_money,
                          )),
                          SizedBox(height: 16),
                          Expanded(
                              child: CustomDecimalInput(
                            controller: viewModel.valorTotalController,
                            hintText: 'Valor Total',
                                icon: Icons.account_balance_wallet_outlined,
                          ))
                        ],
                      ),
                      SizedBox(height: 32),
                      _buildSectionTitle('Observações'),
                      // _buildObservacaoField(viewModel.observacaoController),
                      CustomObservacaoInput(controller: viewModel.observacaoController),
                      const SizedBox(height: 16),
                      _buildSaveButton(viewModel)
                    ],
                  ),
                ),
              ),
            )
          ],
        )));
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(14),
              ),
              child:
                  Icon(Icons.arrow_back, color: AppColors.textDark, size: 22),
            ),
          ),
          SizedBox(width: 16),
          Text(
            widget.ordemId == null
                ? 'Nova Ordem de Serviço'
                : 'Editar Ordem de Serviço',
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 20),
          ),
        ],
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

  void _saveOrUpdate(OrdemServicoViewModel viewModel) async {
    if (widget.ordemId != null) {
      await viewModel.updateOrdem(widget.ordemId!);
    } else {
      await viewModel.saveOrdem();
    }
    if (mounted) Navigator.pop(context);
  }

  Widget _buildSaveButton(OrdemServicoViewModel viewModel) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryBlue, AppColors.accentPurple],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _saveOrUpdate(viewModel),
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Text(
              'Salvar Ordem de Serviço',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildObservacaoField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mediumGray.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child:
      TextFormField(
        controller: controller,
        maxLines: 4,
        style:
        TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark),
        decoration: InputDecoration(
          hintText: 'Observações adicionais...',
          hintStyle: TextStyle(color: AppColors.textGray, fontSize: 15),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}
