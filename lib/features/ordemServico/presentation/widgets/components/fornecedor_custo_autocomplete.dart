import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/fornecedor_provider.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/components/selectable_list_with_input.dart';

import '../../../domain/entities/formato.dart';
import '../../../domain/entities/fornecedor.dart';
import '../../providers/formato_provider.dart';
import 'autocomplete_selector.dart';


class FornecedorCustoAutocomplete extends ConsumerStatefulWidget {
  final void Function(Fornecedor cliente)? onSelected;
  final TextEditingController? controller;
  final String labelText = 'Fornecedor';
  final String hintText = 'Digite o Fornecedor';
  final Fornecedor? initialValue;
  final bool enabled;

  const FornecedorCustoAutocomplete({
    super.key,
    this.onSelected,
    this.controller,
    this.initialValue,
    this.enabled = true,
  });
  @override
  ConsumerState<FornecedorCustoAutocomplete> createState() =>
      _FornecedorCustoAutocompleteState();
}

class _FornecedorCustoAutocompleteState extends ConsumerState<FornecedorCustoAutocomplete> {
  Fornecedor? _selectedFornecedorCusto;
  final String _display = '';
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _selectedFornecedorCusto = widget.initialValue;

    if (_selectedFornecedorCusto != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.text = _selectedFornecedorCusto!.nome;
      });
    }
  }


  void _clearSelection() {
    setState(() {
      _selectedFornecedorCusto = null;
      _controller.clear();
    });
    widget.onSelected?.call(null as Fornecedor);
  }

  // Métodos públicos para controle externo
  Fornecedor? get selectedCliente => _selectedFornecedorCusto;

  void setFornecedorCusto(Fornecedor? FornecedorCusto) {
    setState(() {
      _selectedFornecedorCusto = FornecedorCusto;
      _controller.text = FornecedorCusto?.nome ?? '';
    });
  }

  void clear() {
    _clearSelection();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FornecedorCustoAutocomplete oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != oldWidget.initialValue) {
      _selectedFornecedorCusto = widget.initialValue;
      _controller.text = widget.initialValue?.nome ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatoAsync = ref.watch(fornecedorProvider);
    final formatoNotifier = ref.read(fornecedorProvider.notifier);
    return formatoAsync.when(
      data: (notifier) {
        return SelectableListWithInput<Fornecedor>(
            title: widget.labelText,
            suggestionsCallback: (query) => formatoNotifier.getFornecedoresByNome(query),
            itemBuilder: (p0, item) => ListTile(
              title: Text(item.nome),
            ),
            displayItem: (item) => item.nome,
          onChanged: (selected) {
            // Aqui você pode tratar os itens selecionados + os inputs de valor
            for (var s in selected) {
              print("Selecionado: ${s.item.nome}, valor: ${s.input}");
            }
          }
        ) as Widget;
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Erro ao carregar os Formatos'),
    );
  }
}
