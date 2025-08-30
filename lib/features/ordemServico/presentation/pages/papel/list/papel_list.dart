import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/enums/TipoServico.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/fornecedor_provider.dart';

import '../../../providers/clientes_provider_refactored.dart';
import '../../../providers/papel_provider.dart';
import '../edit/papel_form_page.dart';


class PapelList extends ConsumerStatefulWidget {
  final String filter;
  const PapelList({super.key, this.filter = ''});

  static _PapelListState? of(BuildContext context) {
    final state = context.findAncestorStateOfType<_PapelListState>();
    return state;
  }

  @override
  ConsumerState<PapelList> createState() => _PapelListState();
}

class _PapelListState extends ConsumerState<PapelList> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final asyncNotifier = ref.watch(papelProvider);
    final papelNotifier = ref.read(papelProvider.notifier);

    return asyncNotifier.when(
      data: (notifier) {
        final papeis = notifier;
        final filtered = widget.filter.isEmpty
            ? papeis
            : papeis.where((c) {
                final query = widget.filter.toLowerCase();
                return (c?.descricao.toLowerCase().contains(query) ??
                        false);
              }).toList();
        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final papel = filtered[index];
            return Dismissible(
              key: Key(papel.id),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) async {
                await papelNotifier.delete(papel.id);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Papel excluído')),
                );
              },
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(papel.descricao),
                  subtitle:
                      Text( papel.quantidadePapel.toString()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PapelForm(papelId: papel.id),
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
