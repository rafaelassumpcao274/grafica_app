import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/clientes.dart';
import '../../providers/clientes_provider_refactored.dart';
import '../components/custom_text_input.dart';
import '../components/generics_selector_bottom_sheet.dart';

// COMPONENTE COM FLUTTER_TYPEAHEAD
class ClienteBootomSheetAutocomplete extends ConsumerStatefulWidget {
  final void Function(Clientes cliente)? onSelected;
  final TextEditingController? controller;
  final String labelText = 'Cliente';
  final String hintText = 'Digite o nome do cliente';
  final Clientes? initialValue;
  final bool enabled;

  const ClienteBootomSheetAutocomplete({
    super.key,
    this.onSelected,
    this.controller,
    this.initialValue,
    this.enabled = true,
  });

  @override
  ConsumerState<ClienteBootomSheetAutocomplete> createState() =>
      _ClienteBootomSheetAutocompleteState();
}

class _ClienteBootomSheetAutocompleteState
    extends ConsumerState<ClienteBootomSheetAutocomplete> {
  late TextEditingController _controller;
  Clientes? _selectedCliente;
  final String _display = '';

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _selectedCliente = widget.initialValue;

    if (_selectedCliente != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.text = _selectedCliente!.nomeEmpresa;
      });
    }
  }

  void _clearSelection() {
    setState(() {
      _selectedCliente = null;
      _controller.clear();
    });
    widget.onSelected?.call(null as Clientes);
  }

  // Métodos públicos para controle externo
  Clientes? get selectedCliente => _selectedCliente;

  void setCliente(Clientes? cliente) {
    setState(() {
      _selectedCliente = cliente;
      _controller.text = cliente?.nomeEmpresa ?? '';
    });
  }

  void clearCliente() {
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
  void didUpdateWidget(covariant ClienteBootomSheetAutocomplete oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != oldWidget.initialValue) {
      _selectedCliente = widget.initialValue;
      _controller.text = widget.initialValue?.nomeEmpresa ?? '';
    }
  }

  Future<void> _abrirSelecaoCliente() async {
    final cliente = await showModalBottomSheet<Clientes>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.66,
          child: GenericSelectorBottomSheet<Clientes>(
            provider: clientesNotifierProvider,
            hintText: 'Filtrar cliente',
            displayItem: (cliente) {
              return cliente.nomeEmpresa;
            },
            subtitleItem: (cliente) {
              return cliente.documento;
            },
          ),
        );
      },
    );

    if (cliente == null) {
      return;
    }

    setState(() {
      _selectedCliente = cliente;
      _controller.text = cliente.nomeEmpresa;
    });

    widget.onSelected?.call(cliente);
  }

  @override
  Widget build(BuildContext context) {
    final clientesNotifierAsync = ref.watch(clientesNotifierProvider);

    return clientesNotifierAsync.when(
      data: (notifier) {
        return GestureDetector(
          onTap: widget.enabled ? _abrirSelecaoCliente : null,
          child: AbsorbPointer(
            child: CustomTextInput(
              controller: _controller,
              hintText: 'Cliente',
              icon: Icons.person,
              showBottomSheetIcon: true,
            ),
          ),
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => Container(
        padding: const EdgeInsets.all(16.0),
        child: Text('Erro ao carregar clientes: $error'),
      ),
    );
  }
}
