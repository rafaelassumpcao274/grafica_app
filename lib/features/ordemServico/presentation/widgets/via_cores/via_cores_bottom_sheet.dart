import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/components/custom_btn.dart';

import '../../../domain/entities/via_cores.dart';
import '../../core/theme.dart';
import '../../providers/via_cores_provider.dart';

class ViaCoresBottomSheet extends ConsumerStatefulWidget {
  final List<ViaCores> initialItems;

  const ViaCoresBottomSheet({
    super.key,
    this.initialItems = const [],
  });

  @override
  ConsumerState<ViaCoresBottomSheet> createState() =>
      _ViaCoresBottomSheetState();
}

class _ViaCoresBottomSheetState extends ConsumerState<ViaCoresBottomSheet> {
  late List<ViaCores> _viasSelecionadas;

  @override
  void initState() {
    super.initState();
    _viasSelecionadas = List.from(widget.initialItems);
  }

  bool _isSelected(ViaCores via) {
    return _viasSelecionadas.any(
      (item) => item.descricao.toLowerCase() == via.descricao.toLowerCase(),
    );
  }

  void _toggleVia(ViaCores via) {
    setState(() {
      if (_isSelected(via)) {
        _viasSelecionadas.removeWhere(
          (item) => item.descricao.toLowerCase() == via.descricao.toLowerCase(),
        );
      } else {
        if (_viasSelecionadas.length < 4) {
          _viasSelecionadas.add(via);
        }
      }
    });
  }

  void _concluir() {
    Navigator.pop(context, _viasSelecionadas);
  }

  @override
  Widget build(BuildContext context) {
    final viasAsync = ref.watch(viacoresProvider);

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.65,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Selecionar vias',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: viasAsync.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stack) => Center(
                    child: Text('Erro ao carregar vias: $error'),
                  ),
                  data: (vias) {
                    return ListView.builder(
                      itemCount: vias.length,
                      itemBuilder: (context, index) {
                        final via = vias[index];
                        final selected = _isSelected(via);

                        return ListTile(
                          onTap: () => _toggleVia(via),
                          title: Text(via.descricao),
                          trailing: Checkbox(
                            value: selected,
                            onChanged: (_) => _toggleVia(via),
                            fillColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.selected)) {
                                return AppColors.primaryBlue;
                              }
                              return AppColors.white;
                            }),
                            checkColor: AppColors.white,
                            side: BorderSide(
                              color: AppColors.mediumGray,
                              width: 1.5,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: CustomBtn(text: 'Concluir', onTap: _concluir),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
