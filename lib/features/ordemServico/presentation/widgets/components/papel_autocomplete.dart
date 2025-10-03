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
  bool _showOptions = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!.descricao;
    }

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
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _query = value;
              _showOptions = value.isNotEmpty;
            });
          },
        ),
        if (_showOptions)
          asyncPapeis.when(
            data: (papeis) {
              if (papeis.isEmpty) {
                return const SizedBox.shrink();
              }
              return Material(
                elevation: 4,
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: papeis.length,
                    itemBuilder: (context, index) {
                      final papel = papeis[index];
                      return ListTile(
                        title: Text(papel.descricao),
                        onTap: () {
                          setState(() {
                            _controller.text = papel.descricao;
                            _showOptions = false;
                          });
                          if (widget.onSelected != null) {
                            widget.onSelected!(papel);
                          }
                        },
                      );
                    },
                  ),
                ),
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
            error: (e, _) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Erro: $e'),
            ),
          ),
      ],
    );
  }
}
