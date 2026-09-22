import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom_text_input.dart' show CustomTextInput;

class GenericSelectorBottomSheet<T> extends ConsumerStatefulWidget {
  final ProviderListenable<AsyncValue<List<T>>> provider;

  final String hintText;

  final String Function(T item) displayItem;

  final String Function(T item)? subtitleItem;

  final bool Function(T item, String query)? filter;

  final Comparator<T>? sortComparator;

  final bool initialSortDescending;

  const GenericSelectorBottomSheet({
    super.key,
    required this.provider,
    required this.displayItem,
    this.subtitleItem,
    this.filter,
    this.sortComparator,
    this.initialSortDescending = false,
    this.hintText = 'Filtrar',
  });

  @override
  ConsumerState<GenericSelectorBottomSheet<T>> createState() =>
      _GenericSelectorBottomSheetState<T>();
}

class _GenericSelectorBottomSheetState<T>
    extends ConsumerState<GenericSelectorBottomSheet<T>> {

  final _controller = TextEditingController();

  List<T> _items = [];
  List<T> _allItems = [];
  late bool _sortDescending = widget.initialSortDescending;

  List<T> _ordenar(List<T> items) {
    final comparator = widget.sortComparator;
    if (comparator == null) return items;

    final ordenado = List<T>.of(items)..sort(comparator);
    if (_sortDescending) return ordenado.reversed.toList();
    return ordenado;
  }

  void _filtrar(String texto) {
    final query = texto.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        _items = _ordenar(_allItems);
        return;
      }

      if (widget.filter != null) {
        _items = _ordenar(
          _allItems.where((item) => widget.filter!(item, query)).toList(),
        );
      } else {
        _items = _ordenar(
          _allItems
              .where((item) =>
                  widget.displayItem(item).toLowerCase().contains(query))
              .toList(),
        );
      }
    });
  }

  void _alternarOrdenacao() {
    setState(() {
      _sortDescending = !_sortDescending;
      _items = _ordenar(_items);
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncItems = ref.watch(widget.provider);

    return asyncItems.when(
      loading: () => const SizedBox(
        height: 300,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),

      error: (error, stack) => SizedBox(
        height: 300,
        child: Center(
          child: Text('Erro: $error'),
        ),
      ),

      data: (items) {

        if (!identical(_allItems, items)) {
          _allItems = items;

          if (_controller.text.isEmpty) {
            _items = _ordenar(items);
          }
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                Row(
                  children: [
                    Expanded(
                      child: CustomTextInput(
                        controller: _controller,
                        hintText: widget.hintText,
                        icon: Icons.search,
                        onChange: _filtrar,
                      ),
                    ),

                    if (widget.sortComparator != null) ...[
                      const SizedBox(width: 8),
                      IconButton(
                        tooltip: _sortDescending
                            ? 'Mais recentes primeiro'
                            : 'Mais antigos primeiro',
                        icon: Icon(
                          _sortDescending
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                        ),
                        onPressed: _alternarOrdenacao,
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 16),

                Expanded(
                  child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {

                      final item = _items[index];

                      return ListTile(
                        title: Text(
                          widget.displayItem(item),
                        ),

                        subtitle: widget.subtitleItem != null
                            ? Text(
                          widget.subtitleItem!(item),
                        )
                            : null,

                        onTap: () {
                          Navigator.pop(context, item);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}