import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/formato.dart';
import '../../providers/formato_provider.dart';
import 'autocomplete_selector.dart';


class FormatoAutocomplete extends ConsumerStatefulWidget {
  final void Function(Formato cliente)? onSelected;
  final TextEditingController? controller;
  final String labelText = 'Formato do Papel';
  final String hintText = 'Digite o Formato';
  final Formato? initialValue;
  final bool enabled;

  const FormatoAutocomplete({
    super.key,
    this.onSelected,
    this.controller,
    this.initialValue,
    this.enabled = true,
  });
  @override
  ConsumerState<FormatoAutocomplete> createState() =>
      _FormatoAutocompleteState();
}

class _FormatoAutocompleteState extends ConsumerState<FormatoAutocomplete> {
  Formato? _selectedFormato;
  final String _display = '';
  late TextEditingController _controller;

@override
void initState() {
  super.initState();
  _controller = widget.controller ?? TextEditingController();
  _selectedFormato = widget.initialValue;

  if (_selectedFormato != null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.text = _selectedFormato!.descricao;
    });
  }
}


  void _clearSelection() {
    setState(() {
      _selectedFormato = null;
      _controller.clear();
    });
    widget.onSelected?.call(null as Formato);
  }

  // Métodos públicos para controle externo
  Formato? get selectedCliente => _selectedFormato;

  void setFormato(Formato? formato) {
    setState(() {
      _selectedFormato = formato;
      _controller.text = formato?.descricao ?? '';
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
void didUpdateWidget(covariant FormatoAutocomplete oldWidget) {
  super.didUpdateWidget(oldWidget);

  if (widget.initialValue != oldWidget.initialValue) {
    _selectedFormato = widget.initialValue;
    _controller.text = widget.initialValue?.descricao ?? '';
  }
}

  @override
  Widget build(BuildContext context) {
    final formatoAsync = ref.watch(formatoProvider);
    return formatoAsync.when(
      data: (notifier) {
        return AutoCompleteSelector<Formato>(
          key: widget.key,
          title: widget.labelText,
          suggestionsCallback: (query) => notifier.getFormatoByDescricao(query),
          itemBuilder: (p0, item) => ListTile(
            title: Text(item.descricao),
          ),
          isEnabled: widget.enabled,
          isMultiple: false,
          selectedItem: _selectedFormato,
          displayItem: (item) => item.descricao,
          onSelect: (item) {
            setState(() {
              _selectedFormato = item;
              _controller.text = item?.descricao ?? '';
            });
            widget.onSelected?.call(item);
          },
        ) as Widget;
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Erro ao carregar os Formatos'),
    );
  }
}
