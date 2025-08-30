import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/fornecedorOrdemServico.dart';
import 'package:unilith_app/features/ordemServico/domain/vos/currency.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/fornecedor_provider.dart';

import '../../../domain/entities/fornecedor.dart';
import '../../core/formatter/currency_input_formatter.dart';
import '../../providers/fornecedor_custo_provider.dart';

class FornecedorCustoAutocomplete extends ConsumerStatefulWidget {
  final bool enabled;

  const FornecedorCustoAutocomplete({super.key, this.enabled = true});

  @override
  ConsumerState<FornecedorCustoAutocomplete> createState() => _FornecedorCustoAutocompleteState();
}

class _FornecedorCustoAutocompleteState extends ConsumerState<FornecedorCustoAutocomplete> {
  final Map<FornecedorOrdemServico, TextEditingController> _controllers = {};

  @override
  void dispose() {
    // Libera memória dos controllers
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController _getController(FornecedorOrdemServico fornecedor) {
    return _controllers.putIfAbsent(
      fornecedor,
          () => TextEditingController(text: fornecedor.custo.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fornecedoresProvider = ref.watch(fornecedorCustoProvider);
    final fornecedoresNotifier = ref.read(fornecedorCustoProvider.notifier);
    final fornecedorNotifier = ref.read(fornecedorProvider.notifier);
    final fornecedoresAsync = ref.watch(fornecedorProvider);

    return fornecedoresAsync.when(
      data: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Fornecedor", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),

            TypeAheadField<Fornecedor>(
              suggestionsCallback: (query) =>
                  fornecedorNotifier.getFornecedoresByNome(query),
              itemBuilder: (context, item) => ListTile(title: Text(item.nome)),
              onSelected: (value) {
                final fornecedorOrdem = FornecedorOrdemServico(fornecedor: value, custo: 0.0);
                _controllers[fornecedorOrdem] =
                    TextEditingController(text: fornecedorOrdem.custo.toString());
                 fornecedoresNotifier.addFornecedor(fornecedorOrdem);
              },
              builder: (context, controller, focusNode) {
                return TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: "Informe o Fornecedor",
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
              children: fornecedoresProvider.map((selectedItem) {
                final controller = _getController(selectedItem);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text(selectedItem.fornecedor!.nome)),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            key: ValueKey(selectedItem.id),
                            controller: controller,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              prefixText: 'R\$ ',
                              labelText: "Digite o Valor",
                              border: OutlineInputBorder(),
                            ),
                            onFieldSubmitted: (val) {
                              fornecedoresNotifier.updateFornecedor(
                                fornecedoresProvider.indexOf(selectedItem),
                                selectedItem.copyWith(custo: Currency(val).toDouble()),
                              );
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter(),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            fornecedoresNotifier.removeFornecedor(
                              fornecedoresProvider.indexOf(selectedItem),
                            );
                            _controllers.remove(selectedItem)?.dispose();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Erro ao carregar os fornecedores'),
    );
  }
}


