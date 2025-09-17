import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/via_cores.dart';
import '../../providers/via_cores_provider.dart';

class ChipsInputVia extends ConsumerStatefulWidget {
  final List<ViaCores> initialItems;
  final ValueChanged<List<ViaCores>> onChanged;

  const ChipsInputVia({
    super.key,
    this.initialItems = const [],
    required this.onChanged,
  });

  @override
  ConsumerState<ChipsInputVia> createState() => _ChipsInputViaState();
}

class _ChipsInputViaState extends ConsumerState<ChipsInputVia> {
  late List<ViaCores> _viasSelecionadas;

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

  void _addItem(ViaCores value) {
    final exists = _viasSelecionadas
        .any((v) => v.descricao.toLowerCase() == value.descricao.toLowerCase());
    if (!exists) {
      setState(() {
        _viasSelecionadas.add(value);
      });
      widget.onChanged(_viasSelecionadas);
    }
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
        const SizedBox(height: 8),
        Autocomplete<ViaCores>(
          optionsBuilder: (TextEditingValue textEditingValue) async {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<ViaCores>.empty();
            }
            final results = await ref
                .read(viacoresProvider.notifier)
                .getViaByNome(textEditingValue.text);
            return results;
          },
          displayStringForOption: (via) => via.descricao,
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            return TextField(
              controller: controller,
              focusNode: focusNode,
              enabled: _viasSelecionadas.length < 4,
              decoration: InputDecoration(
                labelText: 'Vias',
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      controller.clear();
                    });
                  },
                )
                    : null,
              ),
            );
          },
          onSelected: (via) {
            _addItem(via);
            // aqui já limpa o campo automaticamente
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // garante que o clear acontece depois do addItem
              FocusScope.of(context).unfocus();
              // se quiser fechar o teclado
            });
          },
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _viasSelecionadas
              .map((via) => Chip(
            label: Text(via.descricao),
            deleteIcon: const Icon(Icons.close),
            onDeleted: () => _removeItem(via),
          ))
              .toList(),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
