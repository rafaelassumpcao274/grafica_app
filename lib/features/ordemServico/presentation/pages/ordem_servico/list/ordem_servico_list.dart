import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/ordemservico_provider.dart';
import '../edit/ordem_servico_form_page.dart';
import '../loading/ordem_servico_skeleton_list.dart';


class OrdemServicoList extends ConsumerStatefulWidget {
  final String filter;
  const OrdemServicoList({super.key, this.filter = ''});

  static _OrdemServicoListState? of(BuildContext context) {
    final state = context.findAncestorStateOfType<_OrdemServicoListState>();
    return state;
  }

  @override
  ConsumerState<OrdemServicoList> createState() => _OrdemServicoListState();
}

class _OrdemServicoListState extends ConsumerState<OrdemServicoList> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final asyncNotifier = ref.watch(ordemServicoProvider);
    final ordemNotifier = ref.read(ordemServicoProvider.notifier);

    return asyncNotifier.when(
      data: (notifier) {
        final ordemServicos = notifier;
        final filtered = (widget.filter.isEmpty
            ? ordemServicos
            : ordemServicos.where((c) {
          final query = widget.filter.toLowerCase();
          return (c.clientes?.nomeEmpresa.toLowerCase().contains(query) ?? false);
        })).toList()
          ..sort((a, b) => b.id.compareTo(a.id));
        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final ordemServico = filtered[index];
            return Dismissible(
              key: Key(ordemServico.id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) async {
                await ordemNotifier.delete(ordemServico.id);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ordem Servico excluída')),
                );
              },

              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.description),
                  title: Text("${ordemServico.id} - ${ordemServico.clientes!.nomeEmpresa}" ??
                      'Cliente não informado'),
                  subtitle: Text(ordemServico.material),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrdemServicoForm(ordemId: ordemServico.id),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      loading: () =>  const OrdemServicoSkeletonList(),
      error: (error, stack) => Center(child: Text('Erro: $error')),
    );
  }

  void filter(String query) {
    setState(() {
      searchQuery = query;
    });
  }
}
