import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/enums/TipoServico.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/formato_provider.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/fornecedor_provider.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/via_cores_provider.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/via_cores_card.dart';

import '../../../core/theme.dart';
import '../../../providers/clientes_provider_refactored.dart';
import '../../../providers/papel_provider.dart';
import '../../../widgets/formato_card.dart';
import '../edit/formato_form_page.dart';


class FormatoList extends ConsumerStatefulWidget {
  final String filter;
  const FormatoList({super.key, this.filter = ''});

  static _FormatoListState? of(BuildContext context) {
    final state = context.findAncestorStateOfType<_FormatoListState>();
    return state;
  }

  @override
  ConsumerState<FormatoList> createState() => _FormatoListState();
}

class _FormatoListState extends ConsumerState<FormatoList> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final asyncNotifier = ref.watch(formatoProvider);
    final formatoNotifier = ref.read(formatoProvider.notifier);

    return asyncNotifier.when(
      data: (notifier) {
        final vias = notifier;
        final filtered = widget.filter.isEmpty
            ? vias
            : vias.where((c) {
                final query = widget.filter.toLowerCase();
                return (c?.descricao.toLowerCase().contains(query) ??
                        false);
              }).toList();

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 100),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final formato = filtered[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlue.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: FormatoCard(formato: formato,
              onEdit: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormatoForm(formatoId: formato.id),
                  ),
                );
              },
                onRemove: () async =>  await formatoNotifier.deleteFormato(formato.id),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Erro: $error')),
    );
  }

  void filter(String query) {
    setState(() {
      searchQuery = query;
    });
  }
}
