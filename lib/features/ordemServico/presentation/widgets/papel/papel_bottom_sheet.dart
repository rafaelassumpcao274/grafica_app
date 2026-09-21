import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/papel.dart';
import '../../core/theme.dart';
import '../../providers/papel_provider.dart';
import '../components/custom_text_input.dart' show CustomTextInput;
import '../components/generics_selector_bottom_sheet.dart'
    show GenericSelectorBottomSheet;

class PapelBottomSheetAutocomplete extends ConsumerStatefulWidget {
  final void Function(Papel papel)? onSelected;
  final Papel? initialValue;

  const PapelBottomSheetAutocomplete({
    super.key,
    this.onSelected,
    this.initialValue,
  });

  @override
  ConsumerState<PapelBottomSheetAutocomplete> createState() =>
      _PapelBottomSheetAutocompleteState();
}

class _PapelBottomSheetAutocompleteState
    extends ConsumerState<PapelBottomSheetAutocomplete> {
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
  void didUpdateWidget(covariant PapelBottomSheetAutocomplete oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != oldWidget.initialValue) {
      _controller.text = widget.initialValue?.descricao ?? '';
      _query = widget.initialValue?.descricao ?? '';
    }
  }

  Future<void> _abrirSelecao() async {
    final papel = await showModalBottomSheet<Papel>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.66,
              child: GenericSelectorBottomSheet<Papel>(
                provider: papelProvider,
                hintText: 'Filtrar papeis',
                displayItem: (papel) {
                  return papel.descricao;
                },
              ));
        });

    if (papel == null) {
      return;
    }

    setState(() {
      // _selectedCliente = cliente;
      _controller.text = papel.descricao;
    });

    widget.onSelected?.call(papel);
  }

  @override
  Widget build(BuildContext context) {
    final asyncPapeis = ref.watch(searchPapelProvider(_query));

    return asyncPapeis.when(
      data: (notifier) {
        return GestureDetector(
          onTap: _abrirSelecao,
          child: AbsorbPointer(
            child: CustomTextInput(
              controller: _controller,
              hintText: "Papel",
              icon: Icons.description_outlined,
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
        child: Text('Erro ao carregar Papeis: $error'),
      ),
    );
  }
}
