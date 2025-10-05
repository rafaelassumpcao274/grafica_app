import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/clientes.dart';
import '../../core/theme.dart';
import '../../providers/clientes_provider_refactored.dart';
import '../components/autocomplete_selector.dart';



// COMPONENTE COM FLUTTER_TYPEAHEAD
class ClienteAutocomplete extends ConsumerStatefulWidget {
  final void Function(Clientes cliente)? onSelected;
  final TextEditingController? controller;
  final String labelText = 'Cliente';
  final String hintText = 'Digite o nome do cliente';
  final Clientes? initialValue;
  final bool enabled;

  const ClienteAutocomplete({
    super.key,
    this.onSelected,
    this.controller,
    this.initialValue,
    this.enabled = true,
  });

  @override
  ConsumerState<ClienteAutocomplete> createState() =>
      _ClienteAutocompleteState();
}

class _ClienteAutocompleteState extends ConsumerState<ClienteAutocomplete> {
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
  void didUpdateWidget(covariant ClienteAutocomplete oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != oldWidget.initialValue) {
      _selectedCliente = widget.initialValue;
      _controller.text = widget.initialValue?.nomeEmpresa ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientesNotifierAsync = ref.watch(clientesNotifierProvider);
    final clienteNotifier = ref.read(clientesNotifierProvider.notifier);

    return clientesNotifierAsync.when(
      data: (notifier) {
        return AutoCompleteSelector<Clientes>(
          key: widget.key,
          prefixIcon: Icon(Icons.person_outline, color: AppColors.primaryBlue, size: 20),
          placeholder: "Informe um cliente ",
          suggestionsCallback: (query) =>
              clienteNotifier.getClientesByNomeEmpresaAlternativo(query),
          itemBuilder: (p0, item) =>
              ListTile(
            title: Text(item.nomeEmpresa),
            subtitle: Text(item.documento),
          ),
          isEnabled: widget.enabled,
          isMultiple: false,
          displayItem: (item) => item.nomeEmpresa,
          selectedItem: _selectedCliente,
          onSelect: (item) {
            setState(() {
              _selectedCliente = item;
              _controller.text = item?.nomeEmpresa ?? '';
            });
            widget.onSelected?.call(item);
          },
        ) as Widget;
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
