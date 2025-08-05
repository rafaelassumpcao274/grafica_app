import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/uf_provider.dart';
import '../../../domain/entities/uf.dart';

class UfAutocomplete extends ConsumerStatefulWidget {
  final void Function(Uf uf)? onSelected;
  final TextEditingController? controller;
  const UfAutocomplete({super.key, this.onSelected, this.controller});

  @override
  ConsumerState<UfAutocomplete> createState() => _UfAutocompleteState();
}

class _UfAutocompleteState extends ConsumerState<UfAutocomplete> {
  Uf? _selectedUf;
  String _display = '';

  @override
  Widget build(BuildContext context) {
    final ufAsync = ref.watch(ufProvider);
    return ufAsync.when(
      data: (ufs) {
        return Autocomplete<Uf>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<Uf>.empty();
            }
            return ufs.where((uf) => uf.sigla
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()));
          },
          displayStringForOption: (Uf uf) => '${uf.descricao} - ${uf.sigla}',
          onSelected: (Uf selection) {
            setState(() {
              _selectedUf = selection;
              _display = '${selection.descricao} - ${selection.sigla}';
            });
            if (widget.controller != null) {
              widget.controller!.text = selection.sigla;
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
                    final uf = options.elementAt(index);
                    return ListTile(
                      title: Text('${uf.descricao} - ${uf.sigla}'),
                      onTap: () => onSelected(uf),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Erro ao carregar UFs'),
    );
  }

  // Não é mais necessário buscar descricao separadamente
}
