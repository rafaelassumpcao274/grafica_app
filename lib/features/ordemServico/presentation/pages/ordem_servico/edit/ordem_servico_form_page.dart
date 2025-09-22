import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/viaCoresOrdemServico.dart';
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
      appBar: AppBar(
        title: Text(widget.ordemId != null
            ? 'Editar Ordem de Serviço'
            : 'Nova Ordem de Serviço'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClienteAutocomplete(
                  initialValue: viewModel.selectedCliente,
                  onSelected: (c) => viewModel.selectedCliente = c,
                ),
                const SizedBox(height: 16),
                CustomTextInput(
                  controller: viewModel.materialController,
                  hintText: 'Material',
                  icon: Icons.article,
                ),
                const SizedBox(height: 16),
                CustomTextInput(
                  controller: viewModel.tamanhoImagemController,
                  hintText: 'Tamanho',
                  icon: Icons.image,
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
                  ),
                  const SizedBox(height: 16),
                  CustomIntegerInput(
                      controller: viewModel.numeracaoFinalController,
                      hintText: 'Numeração Final',
                      useThousandsSeparator: true,),
                ],
                const SizedBox(height: 16),
                const FornecedorCustoAutocomplete(),
                const SizedBox(height: 16),
                CustomDecimalInput(
                  controller: viewModel.valorCustoController,
                  hintText: 'Valor Custo',
                  enabled: false,
                ),
                const SizedBox(height: 16),
                CustomDecimalInput(
                  controller: viewModel.valorTotalController,
                  hintText: 'Valor Total',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: viewModel.observacaoController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Observação',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (widget.ordemId != null) {
                        await viewModel.updateOrdem(widget.ordemId!);
                      } else {
                        await viewModel.saveOrdem();
                      }
                      if (mounted) Navigator.pop(context);
                    },
                    child: const Text('Salvar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
