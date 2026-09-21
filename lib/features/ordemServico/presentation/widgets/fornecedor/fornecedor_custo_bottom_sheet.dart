import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/components/custom_decimal_input.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/components/fornecedor_custo_autocomplete_view_model.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/fornecedor/fornecedor_custo_controller.dart';

import '../../../domain/entities/fornecedor.dart';
import '../../providers/fornecedor_provider.dart';
import '../components/custom_text_input.dart';
import '../components/generics_selector_bottom_sheet.dart';

class FornecedorCustoBottomSheet extends ConsumerStatefulWidget {
  final bool enabled;
  final FornecedorCustoController initialValue;

  const FornecedorCustoBottomSheet({
    super.key,
    this.enabled = true,
    required this.initialValue,
  });

  @override
  ConsumerState<FornecedorCustoBottomSheet> createState() =>
      _FornecedorCustoBottomSheetState();
}

class _FornecedorCustoBottomSheetState
    extends ConsumerState<FornecedorCustoBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _abrirSelecaoFornecedor(
      FornecedorCustoViewModel viewModel) async {
    final fornecedor = await showModalBottomSheet<Fornecedor>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.66,
          child: GenericSelectorBottomSheet<Fornecedor>(
            provider: fornecedorNotifierProvider,
            hintText: 'Filtrar fornecedor',
            displayItem: (fornecedor) {
              return fornecedor.nome;
            },
            subtitleItem: (fornecedor) {
              return fornecedor.contato;
            },
          ),
        );
      },
    );

    if (fornecedor == null) {
      return;
    }

    viewModel.addFornecedor(fornecedor);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel =
        ref.watch(fornecedorCustoViewModelProvider(widget.initialValue));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: widget.enabled
              ? () => _abrirSelecaoFornecedor(viewModel)
              : null,
          child: AbsorbPointer(
            child: CustomTextInput(
              controller: _controller,
              hintText: 'Informe o Fornecedor',
              icon: Icons.business_outlined,
              showBottomSheetIcon: true,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: [
            ValueListenableBuilder(
              valueListenable: viewModel.fornecedorController,
              builder: (context, value, child) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final controller = viewModel.getController(value[index]);
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Text(value[index].fornecedor!.nome)),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 4,
                              child: CustomDecimalInput(
                                controller: controller,
                                hintText: "Custo",
                                onChanged: (val) =>
                                    viewModel.updateFornecedor(index, val),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  viewModel.removeFornecedor(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ],
    );
  }
}
