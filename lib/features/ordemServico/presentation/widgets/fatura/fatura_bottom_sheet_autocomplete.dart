import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/fatura_resumo_dto.dart';
import '../../providers/fatura_provider.dart';
import '../components/custom_text_input.dart';
import '../components/generics_selector_bottom_sheet.dart';

class FaturaBottomSheetAutocomplete extends ConsumerStatefulWidget {
  final void Function(FaturaResumoDto fatura)? onSelected;
  final TextEditingController? controller;
  final String hintText;
  final FaturaResumoDto? initialValue;
  final bool enabled;

  const FaturaBottomSheetAutocomplete({
    super.key,
    this.onSelected,
    this.controller,
    this.initialValue,
    this.enabled = true,
    this.hintText = 'Fatura (opcional)',
  });

  @override
  ConsumerState<FaturaBottomSheetAutocomplete> createState() =>
      _FaturaBottomSheetAutocompleteState();
}

class _FaturaBottomSheetAutocompleteState
    extends ConsumerState<FaturaBottomSheetAutocomplete> {
  late TextEditingController _controller;
  FaturaResumoDto? _selectedFatura;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _selectedFatura = widget.initialValue;

    if (_selectedFatura != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.text = _display(_selectedFatura!);
      });
    }
  }

  @override
  void didUpdateWidget(covariant FaturaBottomSheetAutocomplete oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != oldWidget.initialValue) {
      _selectedFatura = widget.initialValue;
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

  String _display(FaturaResumoDto f) =>
      'Fatura #${f.id} — ${f.clienteNome ?? "Sem cliente"}';

  String _subtitle(FaturaResumoDto f) =>
      f.osNumeroMaterial != null ? 'OS: ${f.osNumeroMaterial}' : 'Sem OS vinculada';

  Future<void> _abrirSelecao() async {
    final fatura = await showModalBottomSheet<FaturaResumoDto>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.66,
          child: GenericSelectorBottomSheet<FaturaResumoDto>(
            provider: faturaProvider,
            hintText: 'Filtrar por número, cliente ou OS',
            displayItem: _display,
            subtitleItem: _subtitle,
          ),
        );
      },
    );

    if (fatura == null) return;

    setState(() {
      _selectedFatura = fatura;
      _controller.text = _display(fatura);
    });

    widget.onSelected?.call(fatura);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.enabled ? _abrirSelecao : null,
      child: AbsorbPointer(
        child: CustomTextInput(
          controller: _controller,
          hintText: widget.hintText,
          icon: Icons.receipt_long_outlined,
          showBottomSheetIcon: true,
        ),
      ),
    );
  }
}
