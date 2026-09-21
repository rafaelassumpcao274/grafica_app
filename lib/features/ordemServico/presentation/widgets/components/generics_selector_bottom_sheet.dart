import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom_text_input.dart' show CustomTextInput;

class GenericSelectorBottomSheet<T> extends ConsumerStatefulWidget {
  final ProviderListenable<AsyncValue<List<T>>> provider;

  final String hintText;

  final String Function(T item) displayItem;

  final String Function(T item)? subtitleItem;

  final bool Function(T item, String query)? filter;

  const GenericSelectorBottomSheet({
    super.key,
    required this.provider,
    required this.displayItem,
    this.subtitleItem,
    this.filter,
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

  void _filtrar(String texto) {
    final query = texto.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        _items = _allItems;
        return;
      }

      if (widget.filter != null) {
        _items = _allItems
            .where((item) => widget.filter!(item, query))
            .toList();
      } else {
        _items = _allItems.where((item) {
          return widget
              .displayItem(item)
              .toLowerCase()
              .contains(query);
        }).toList();
      }
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
            _items = items;
          }
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                CustomTextInput(
                  controller: _controller,
                  hintText: widget.hintText,
                  icon: Icons.search,
                  onChange: _filtrar,
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