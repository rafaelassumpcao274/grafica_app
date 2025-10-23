import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/components/custom_btn.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/components/custom_header_with_btn_back.dart';
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
            CustomHeaderWithBtnBack(
                text: widget.ordemId == null
                    ? 'Nova Ordem de Serviço'
                    : 'Editar Ordem de Serviço'),
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
                      _buildNumeracaoSwitch(viewModel),
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
                          validator: (value) {
                            if (value != null) {
                              final numIni =
                                  viewModel.numeracaoInicialController.number;

                              if (numIni != null && numIni! > 0) {
                                return (int.parse(value) < numIni)
                                    ? "Numeração final e menor que o inicial !!!"
                                    : "";
                              }
                            }
                            return "";
                          },
                        ),
                      ],
                      SizedBox(height: 32),
                      _buildSectionTitle('Fornecedor'),
                      const SizedBox(height: 16),
                      FornecedorCustoAutocomplete(
                        initialValue: viewModel.fornecedorCustoController,
                      ),
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
                      CustomObservacaoInput(
                          controller: viewModel.observacaoController),
                      const SizedBox(height: 16),
                      CustomBtn(
                          text: 'Salvar Ordem de Serviço',
                          onTap: () => _saveOrUpdate(viewModel))
                    ],
                  ),
                ),
              ),
            )
          ],
        )));
  }

  Widget _buildNumeracaoSwitch(OrdemServicoViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(20),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.success.withValues(alpha: 0.15),
                      AppColors.success.withValues(alpha: 0.1)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.format_list_numbered,
                    color: AppColors.success, size: 22),
              ),
              SizedBox(width: 14),
              Text('Possui numeração',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark)),
            ],
          ),
          Switch(
            value: viewModel.possuiNumeracao,
            onChanged: (value) =>
                setState(() => viewModel.possuiNumeracao = value),
            activeColor: AppColors.success,
            activeTrackColor: AppColors.success.withValues(alpha: 0.3),
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
}
