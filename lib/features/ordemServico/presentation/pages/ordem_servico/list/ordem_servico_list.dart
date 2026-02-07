import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/ordem_card.dart';

import '../../../providers/ordemservico_provider.dart';
import '../edit/ordem_servico_form_page.dart';
import '../loading/ordem_servico_skeleton_list.dart';


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../providers/ordemservico_provider.dart';
import '../edit/ordem_servico_form_page.dart';
import '../loading/ordem_servico_skeleton_list.dart';

class OrdemServicoList extends ConsumerStatefulWidget {
  final String filter;
  const OrdemServicoList({super.key, this.filter = ''});

  static _OrdemServicoListState? of(BuildContext context) {
    return context.findAncestorStateOfType<_OrdemServicoListState>();
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
      data: (ordens) {
        final filtered = (widget.filter.isEmpty
            ? ordens
            : ordens.where((c) {
          final query = widget.filter.toLowerCase();
          return (c.clientes?.nomeEmpresa.toLowerCase().contains(query) ??
              false);
        })).toList()
          ..sort((a, b) => b.id.compareTo(a.id));

        if (filtered.isEmpty) {
          return const Center(child: Text("Nenhuma Ordem de Serviço encontrada"));
        }

        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final ordemServico = filtered[index];
            print(ordemServico.createdAt.runtimeType);
            print(ordemServico.createdAt);

            final createdAtFormatted = ordemServico.createdAt != null
                ? DateFormat('dd/MM/yyyy HH:mm').format(ordemServico.createdAt!)
                : 'Data não informada';

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
                  const SnackBar(content: Text('Ordem de Serviço excluída')),
                );
              },
              child:
                OrdemCard(ordem: ordemServico),
            );
          },
        );
      },
      loading: () => const OrdemServicoSkeletonList(),
      error: (error, stack) => Center(child: Text('Erro: $error')),
    );
  }

  void filter(String query) {
    setState(() {
      searchQuery = query;
    });
  }
}
