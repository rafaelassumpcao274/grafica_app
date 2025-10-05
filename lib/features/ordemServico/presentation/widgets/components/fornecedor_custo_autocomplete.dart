import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../domain/entities/fornecedor.dart';
import '../../../domain/entities/fornecedorOrdemServico.dart';
import '../../../domain/provider/providers.dart';
import '../../core/formatter/currency_input_formatter.dart';
import '../../core/theme.dart';
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
        TypeAheadField<Fornecedor>(
          suggestionsCallback: (query) async {

            final repo = await ref.read(fornecedorRepositoryProvider.future);
            if (query.isEmpty) await repo.getFornecedores();
            return repo.getFornecedorPaginated(search: query);
          },
          itemBuilder: (context, item) => ListTile(title: Text(item.nome)),
          onSelected: (value) {
            viewModel.addFornecedor(value);
          },
          builder: (context, controller, focusNode) {
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
                child:TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textDark),
                  decoration: InputDecoration(
                    hintText: "Informe o Fornecedor",
                    hintStyle: TextStyle(color: AppColors.textGray, fontSize: 15),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Container(
                      margin: EdgeInsets.all(12),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.accentPurple.withValues(alpha: 0.15), AppColors.accentPink.withValues(alpha: 0.15)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.business_outlined, color: AppColors.accentPurple, size: 20),
                    ),
                    prefixStyle: TextStyle(color: AppColors.textDark, fontSize: 15, fontWeight: FontWeight.w600),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => controller.clear(),
                    ),
                  ),
                ))
              ;
          },
        ),
        const SizedBox(height: 8),
        Column(
          children: fornecedores.map((fornecedor) {
            final controller = viewModel.getController(fornecedor);
            final index = fornecedores.indexOf(fornecedor);

            return Card(
              color: AppColors.white,
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
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
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
