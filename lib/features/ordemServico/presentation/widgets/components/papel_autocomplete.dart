import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/papel.dart';
import '../../providers/papel_provider.dart';

class PapelAutocomplete extends ConsumerStatefulWidget {
  final void Function(Papel papel)? onSelected;
  final TextEditingController? controller;
  const PapelAutocomplete({super.key, this.onSelected, this.controller});

  @override
  ConsumerState<PapelAutocomplete> createState() => _PapelAutocompleteState();
}

class _PapelAutocompleteState extends ConsumerState<PapelAutocomplete> {
  Papel? _selectedPapel;
  String _display = '';

  @override
  Widget build(BuildContext context) {
    final papelAsync = ref.watch(papelProvider);
    return papelAsync.when(
      data: (papels) {
        return Autocomplete<Papel>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<Papel>.empty();
            }
            return papels.where((papel) => papel.descricao
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()));
          },
          displayStringForOption: (Papel papel) => papel.descricao,
          onSelected: (Papel selection) {
            setState(() {
              _selectedPapel = selection;
              _display = selection.descricao;
            });
            if (widget.controller != null) {
              widget.controller!.text = selection.descricao;
            }
            if (widget.onSelected != null) widget.onSelected!(selection);
          },
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            return TextField(
              controller: widget.controller ?? controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: 'UF',
                hintText: 'Digite a sigla da UF',
                border: OutlineInputBorder(),
              ),
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final papel = options.elementAt(index);
                    return ListTile(
                      title: Text('${papel.descricao} '),
                      onTap: () => onSelected(papel),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Erro ao carregar os Papeis'),
    );
  }

  // Não é mais necessário buscar descricao separadamente
}
