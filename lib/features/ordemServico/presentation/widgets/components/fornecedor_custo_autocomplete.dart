import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/fornecedorOrdemServico.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/fornecedor_provider.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/components/selectable_list_with_input.dart';

import '../../../domain/entities/formato.dart';
import '../../../domain/entities/fornecedor.dart';
import '../../providers/formato_provider.dart';
import '../../providers/fornecedor_custo_provider.dart';
import 'autocomplete_selector.dart';

class FornecedorCustoAutocomplete extends ConsumerWidget {
  final bool enabled;

  const FornecedorCustoAutocomplete({
    super.key,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fornecedoresSelecionados = ref.watch(fornecedorCustoProvider);
    final fornecedorNotifier = ref.read(fornecedorProvider.notifier);
    final fornecedoresAsync = ref.watch(fornecedorProvider);

    // Cria uma chave que muda sempre que a lista de fornecedores selecionados mudar
    final keyString = fornecedoresSelecionados
        .map((f) => f.fornecedor?.id ?? '')
        .join('-');

    return fornecedoresAsync.when(
      data: (_) {
        return SelectableListWithInput<Fornecedor>(
          key: ValueKey(keyString), // chave dinâmica
          title: 'Fornecedor',
          suggestionsCallback: (query) =>
              fornecedorNotifier.getFornecedoresByNome(query),
          itemBuilder: (context, item) => ListTile(
            title: Text(item.nome),
          ),
          displayItem: (item) => item.nome,
          initialSelected: fornecedoresSelecionados
              .map((fos) => SelectableItem<Fornecedor>(
            item: fos.fornecedor!,
            input: fos.custo.toString(),
          ))
              .toList(),
          onChanged: (selected) {
            final list = selected
                .map((it) => FornecedorOrdemServico(
              fornecedor: it.item,
              custo: double.tryParse(it.input ?? '0.0') ?? 0.0,
            ))
                .toList();

            ref.read(fornecedorCustoProvider.notifier).setFornecedores(list);
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Erro ao carregar os fornecedores'),
    );
  }


}

