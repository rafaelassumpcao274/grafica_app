import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/papel.dart';
import '../../core/theme.dart';
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

    return
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
          child:

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textDark),
                decoration: const InputDecoration(
                    labelText: 'Papel',
                    hintText: 'Digite o nome do papel',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.description_outlined, color: AppColors.textGray, size: 20),
                    prefixStyle: TextStyle(color: AppColors.textDark, fontSize: 15, fontWeight: FontWeight.w600),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16)
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
          )
      );
  }
}
