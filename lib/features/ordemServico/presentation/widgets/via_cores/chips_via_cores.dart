import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../domain/entities/via_cores.dart';
import '../../core/theme.dart';
import '../components/custom_text_input.dart' show CustomTextInput;
import 'via_cores_bottom_sheet.dart';

class ChipsInputVia extends StatefulWidget {
  final List<ViaCores> initialItems;
  final ValueChanged<List<ViaCores>> onChanged;

  const ChipsInputVia({
    super.key,
    this.initialItems = const [],
    required this.onChanged,
  });

  @override
  State<ChipsInputVia> createState() => _ChipsInputViaState();
}

class _ChipsInputViaState extends State<ChipsInputVia> {
  late List<ViaCores> _viasSelecionadas;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viasSelecionadas = List.from(widget.initialItems);
  }

  @override
  void didUpdateWidget(covariant ChipsInputVia oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialItems != widget.initialItems) {
      setState(() {
        _viasSelecionadas = List.from(widget.initialItems);
      });
    }
  }

  Future<void> _abrirSelecao() async {
    final resultado = await showModalBottomSheet<List<ViaCores>>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return ViaCoresBottomSheet(
          initialItems: _viasSelecionadas,
        );
      },
    );

    if (resultado == null) {
      return;
    }

    setState(() {
      _viasSelecionadas = resultado;
    });

    widget.onChanged(_viasSelecionadas);
  }

  void _removeItem(ViaCores via) {
    setState(() {
      _viasSelecionadas.remove(via);
    });

    widget.onChanged(_viasSelecionadas);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextInput(
          controller: _controller,
          hintText: 'Vias',
          icon: Symbols.layers,
          readOnly: true,
          showBottomSheetIcon: true,
          onTap: _abrirSelecao,
        ),

        const SizedBox(height: 8),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _viasSelecionadas
              .map(
                (via) => Chip(
              label: Text(via.descricao),
              deleteIcon: const Icon(Icons.close),
              onDeleted: () => _removeItem(via),
            ),
          )
              .toList(),
        ),

        const SizedBox(height: 8),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}