import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/papel.dart';
import '../../providers/papel_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/papel.dart';
import '../../providers/papel_provider.dart';

class PapelAutocomplete extends ConsumerStatefulWidget {
  final void Function(Papel papel)? onSelected;
  final Papel? initialValue;

  const PapelAutocomplete({
    super.key,
    this.onSelected,
    this.initialValue,
  });

  @override
  ConsumerState<PapelAutocomplete> createState() => _PapelAutocompleteState();
}

class _PapelAutocompleteState extends ConsumerState<PapelAutocomplete> {
  late TextEditingController _controller;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!.descricao;
    }

    // inicializa a query
    _query = widget.initialValue?.descricao ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final asyncPapeis = ref.watch(searchPapelProvider(_query));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Papel',
            hintText: 'Digite o nome do papel',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() => _query = value); // dispara nova busca
          },
        ),
      ],
    );
  }
}
