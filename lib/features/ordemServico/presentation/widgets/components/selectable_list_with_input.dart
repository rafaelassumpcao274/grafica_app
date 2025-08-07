import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SelectableListWithInput<T> extends StatefulWidget {
  final String title;
  final Future<List<T>> Function(String) suggestionsCallback;
  final String Function(T) displayItem;
  final Widget Function(BuildContext, T) itemBuilder;
  final void Function(List<SelectableItem<T>>) onChanged;
  final String placeholder;

  const SelectableListWithInput({
    super.key,
    required this.title,
    required this.suggestionsCallback,
    required this.displayItem,
    required this.itemBuilder,
    required this.onChanged,
    this.placeholder = "Selecione um item",
  });

  @override
  State<SelectableListWithInput<T>> createState() =>
      _SelectableListWithInputState<T>();
}

class SelectableItem<T> {
  final T item;
  String? input;

  SelectableItem({required this.item, this.input});
}

class _SelectableListWithInputState<T> extends State<SelectableListWithInput<T>> {
  final TextEditingController _controller = TextEditingController();
  final List<SelectableItem<T>> _selectedItems = [];

  void _onItemSelected(T item) {
    if (_selectedItems.any((e) => e.item == item)) return;
    setState(() {
      _selectedItems.add(SelectableItem(item: item));
      _controller.clear();
    });
    widget.onChanged(_selectedItems);
  }

  void _removeItem(SelectableItem<T> selectedItem) {
    setState(() {
      _selectedItems.remove(selectedItem);
    });
    widget.onChanged(_selectedItems);
  }

  void _updateInput(SelectableItem<T> selectedItem, String value) {
    setState(() {
      selectedItem.input = value;
    });
    widget.onChanged(_selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TypeAheadField<T>(
          suggestionsCallback: widget.suggestionsCallback,
          itemBuilder: widget.itemBuilder,
          onSelected: _onItemSelected,
          builder: (context, TextEditingController controller, FocusNode focusNode) {
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: widget.placeholder,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => controller.clear(),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Column(
          children: _selectedItems.map((selectedItem) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(widget.displayItem(selectedItem.item)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        initialValue: selectedItem.input,
                        decoration: const InputDecoration(
                          hintText: "Digite valor",
                          border: OutlineInputBorder(),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                        ),
                        onChanged: (val) =>
                            _updateInput(selectedItem, val.trim()),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeItem(selectedItem),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
