import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/ordemservico.dart';
import '../../providers/ordemservico_provider.dart';
import '../components/custom_text_input.dart';
import '../components/generics_selector_bottom_sheet.dart';

class OrdemServicoBottomSheetAutocomplete extends ConsumerStatefulWidget {
  final void Function(OrdemServico ordem)? onSelected;
  final TextEditingController? controller;
  final String hintText;
  final OrdemServico? initialValue;
  final bool enabled;

  const OrdemServicoBottomSheetAutocomplete({
    super.key,
    this.onSelected,
    this.controller,
    this.initialValue,
    this.enabled = true,
    this.hintText = 'Ordem de Serviço (opcional)',
  });

  @override
  ConsumerState<OrdemServicoBottomSheetAutocomplete> createState() =>
      _OrdemServicoBottomSheetAutocompleteState();
}

class _OrdemServicoBottomSheetAutocompleteState
    extends ConsumerState<OrdemServicoBottomSheetAutocomplete> {
  late TextEditingController _controller;
  OrdemServico? _selectedOrdem;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _selectedOrdem = widget.initialValue;

    if (_selectedOrdem != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.text = _display(_selectedOrdem!);
      });
    }
  }

  @override
  void didUpdateWidget(covariant OrdemServicoBottomSheetAutocomplete oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != oldWidget.initialValue) {
      _selectedOrdem = widget.initialValue;
      _controller.text =
          widget.initialValue != null ? _display(widget.initialValue!) : '';
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  String _display(OrdemServico os) => '#${os.id} - ${os.material}';

  Future<void> _abrirSelecao() async {
    final ordem = await showModalBottomSheet<OrdemServico>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.66,
          child: GenericSelectorBottomSheet<OrdemServico>(
            provider: ordemServicoProvider,
            hintText: 'Filtrar por número ou material',
            displayItem: _display,
            subtitleItem: (os) =>
                os.clientes?.nomeEmpresa ?? 'Cliente não informado',
            sortComparator: (a, b) => a.id.compareTo(b.id),
            initialSortDescending: true,
          ),
        );
      },
    );

    if (ordem == null) return;

    setState(() {
      _selectedOrdem = ordem;
      _controller.text = _display(ordem);
    });

    widget.onSelected?.call(ordem);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.enabled ? _abrirSelecao : null,
      child: AbsorbPointer(
        child: CustomTextInput(
          controller: _controller,
          hintText: widget.hintText,
          icon: Icons.description_outlined,
          showBottomSheetIcon: true,
        ),
      ),
    );
  }
}
