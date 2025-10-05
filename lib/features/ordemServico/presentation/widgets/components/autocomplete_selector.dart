import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../core/theme.dart';

class AutoCompleteSelector<T> extends StatefulWidget {
  final List<T> selectedItems;
  final T? selectedItem;
  final Function(dynamic) onSelect;
  final Future<List<T>> Function(String) suggestionsCallback;
  final String Function(T) displayItem;
  final Widget Function(BuildContext, T) itemBuilder;
  final bool isMultiple;
  final bool isLoading;
  final String placeholder;
  final Icon? prefixIcon;
  final bool isEnabled;
  final bool isRequired;
  final FormFieldValidator<String>? validator;
  final ScrollController? scrollController; // novo parâmetro

  const AutoCompleteSelector(
      {super.key,
      required this.suggestionsCallback,
      required this.displayItem,
      required this.itemBuilder,
      required this.onSelect,
      this.selectedItems = const [],
      this.selectedItem,
      this.isMultiple = false,
      this.isLoading = false,
      this.placeholder = "Selecione um item",
      this.prefixIcon = const Icon(Icons.search, color: Colors.grey),
      this.isEnabled = true,
      this.isRequired = false,
      this.validator,
      this.scrollController});

  @override
  _AutoCompleteSelectorState<T> createState() =>
      _AutoCompleteSelectorState<T>();
}

class _AutoCompleteSelectorState<T> extends State<AutoCompleteSelector<T>> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late List<T> _selectedItems;
  T? _selectedItem;
  final GlobalKey _fieldKey =
      GlobalKey(); // ⬅️ Para capturar o contexto do campo
  late final StreamSubscription<bool> _kbSubscription;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _selectedItems = List.from(widget.selectedItems);
    _selectedItem = widget.selectedItem;
    if (!widget.isMultiple && _selectedItem != null) {
      _controller.text = widget.displayItem(_selectedItem as T);
    }

    _controller.addListener(() {
      setState(() {}); // Atualiza o ícone de limpeza dinamicamente
    });

    _kbSubscription = KeyboardVisibilityController().onChange.listen((bool visible) {
      if (visible && _focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (_fieldKey.currentContext != null) {
            Scrollable.ensureVisible(
              _fieldKey.currentContext!,
              alignment: 0.0,
              curve: Curves.easeInOut,
            );
          }
        });
      }
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _kbSubscription.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AutoCompleteSelector<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedItem != oldWidget.selectedItem) {
      _selectedItem = widget.selectedItem;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_selectedItem != null) {
          _controller.text = widget.displayItem(_selectedItem as T);
        } else {
          _controller.clear();
        }
      });
    }

    if (widget.isMultiple && widget.selectedItems != oldWidget.selectedItems) {
      _selectedItems = List.from(widget.selectedItems);
    }
  }

  void _selectSingleItem(T item) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _selectedItem = item;
        _controller.text = widget.displayItem(item);
      });
      widget.onSelect(item);
      FocusScope.of(context).unfocus();
    });
  }

  void _removeItem(T item) {
    setState(() {
      _selectedItems.remove(item);
    });
    widget.onSelect(_selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child:
          Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.mediumGray.withValues(alpha: 0.3)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlue.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TypeAheadField<T>(
                  controller: _controller,
                  focusNode: _focusNode,
                  suggestionsCallback: widget.suggestionsCallback,
                  itemBuilder: (context, T item) => widget.itemBuilder(context, item),
                  onSelected: (T item) {
                    if (widget.isMultiple) {
                      if (!_selectedItems.contains(item)) {
                        setState(() {
                          _selectedItems.add(item);
                          _controller.clear();
                        });
                        widget.onSelect(_selectedItems);
                      }
                    } else {
                      _selectSingleItem(item);
                    }
                  },
                  errorBuilder: (context, error) => const Text('Ocorreu um erro!'),
                  emptyBuilder: (context) => const Text('Nenhum item encontrado!'),
                  builder: (context, _, __) {
                    return TextFormField(
                      key: _fieldKey,
                      controller: _controller,
                      focusNode: _focusNode,
                      enabled: widget.isEnabled,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textDark),
                      decoration: InputDecoration(
                          hintText: widget.placeholder,
                          hintStyle: TextStyle(color: AppColors.textGray, fontSize: 15),
                        prefixIcon: Container(
                          margin: EdgeInsets.all(12),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.primaryBlue.withValues(alpha: 0.15), AppColors.accentPurple.withValues(alpha: 0.15)],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: widget.prefixIcon,
                        ),
                          prefixStyle: TextStyle(color: AppColors.textDark, fontSize: 15, fontWeight: FontWeight.w600),
                          suffixIcon: _controller.text.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _controller.clear();
                                if (!widget.isMultiple) {
                                  _selectedItem = null;
                                  widget.onSelect(null);
                                }
                              });
                            },
                          )
                              : null,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16)
                      ),
                      validator: widget.validator ??
                              (value) {
                            if (widget.isRequired &&
                                (value == null || value.trim().isEmpty)) {
                              return 'Preencha este campo';
                            }
                            return null;
                          },
                    );
                  },
                ),
                const SizedBox(height: 2),
                if (widget.isMultiple)
                  Wrap(
                    spacing: 6.0,
                    children: _selectedItems.map((item) {
                      return Chip(
                        label: Text(
                          widget.displayItem(item),
                          style: const TextStyle(color: Colors.green),
                        ),
                        shadowColor: Colors.green,
                        onDeleted: () => _removeItem(item),
                        deleteIcon:
                        const Icon(Icons.close, size: 18, color: Colors.red),
                      );
                    }).toList(),
                  ),
              ],
            ),
          )

    );
  }
}
