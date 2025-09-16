import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/enums/TipoServico.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/fornecedor_provider.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/via_cores_provider.dart';

import '../../../providers/clientes_provider_refactored.dart';
import '../../../providers/papel_provider.dart';
import '../edit/via_cores_form_page.dart';


class ViaCoresList extends ConsumerStatefulWidget {
  final String filter;
  const ViaCoresList({super.key, this.filter = ''});

  static _ViaCoresListState? of(BuildContext context) {
    final state = context.findAncestorStateOfType<_ViaCoresListState>();
    return state;
  }

  @override
  ConsumerState<ViaCoresList> createState() => _ViaCoresListState();
}

class _ViaCoresListState extends ConsumerState<ViaCoresList> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final asyncNotifier = ref.watch(viacoresProvider);
    final viacoresNotifier = ref.read(viacoresProvider.notifier);

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
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final viacores = filtered[index];
            return Dismissible(
              key: Key(viacores.id),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) async {
                await viacoresNotifier.delete(viacores.id);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Via excluída')),
                );
              },
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.format_color_fill_sharp),
                  title: Text(viacores.descricao),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViaCoresForm(viacoresId: viacores.id),
                      ),
                    );
                  },
                ),
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
