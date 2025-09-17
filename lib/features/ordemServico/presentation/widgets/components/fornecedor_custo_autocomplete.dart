import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../domain/entities/fornecedor.dart';
import '../../../domain/entities/fornecedorOrdemServico.dart';
import '../../core/formatter/currency_input_formatter.dart';
import 'fornecedor_custo_autocomplete_view_model.dart';

class FornecedorCustoAutocomplete extends ConsumerStatefulWidget {
  final bool enabled;

  const FornecedorCustoAutocomplete({
    super.key,
    this.enabled = true,
  });

  @override
  ConsumerState<FornecedorCustoAutocomplete> createState() =>
      _FornecedorCustoAutocompleteState();
}

class _FornecedorCustoAutocompleteState
    extends ConsumerState<FornecedorCustoAutocomplete> {



  @override
  Widget build(BuildContext context) {
    final fornecedores = ref.watch(fornecedorCustoViewModelProvider);
    final viewModel = ref.read(fornecedorCustoViewModelProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Fornecedor", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),

        TypeAheadField<Fornecedor>(
          suggestionsCallback: (query) async {
            final result = await ref.watch(searchFornecedorProvider(query).future);
            return result;
          },
          itemBuilder: (context, item) => ListTile(title: Text(item.nome)),
          onSelected: (value) {
            viewModel.addFornecedor(
              value,
            );
          },
          builder: (context, controller, focusNode) {
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: "Informe o Fornecedor",
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => controller.clear(),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 8),

        Column(
          children: fornecedores.map((fornecedor) {
            final controller = viewModel.getController(fornecedor);
            final index = fornecedores.indexOf(fornecedor);

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text(fornecedor.fornecedor!.nome)),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        key: ValueKey(fornecedor.id),
                        controller: controller,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          prefixText: 'R\$ ',
                          labelText: "Digite o Valor",
                          border: OutlineInputBorder(),
                        ),
                        onFieldSubmitted: (val) =>
                            viewModel.updateFornecedor(index, val),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter(),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => viewModel.removeFornecedor(index),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
