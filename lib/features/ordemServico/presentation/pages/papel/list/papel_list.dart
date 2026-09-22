
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/papel_card.dart';

import '../../../providers/papel_provider.dart';

class PapelList extends ConsumerStatefulWidget {
  final String filter;
  const PapelList({super.key, this.filter = ''});

  static _PapelListState? of(BuildContext context) {
    return context.findAncestorStateOfType<_PapelListState>();
  }

  @override
  ConsumerState<PapelList> createState() => _PapelListState();
}

class _PapelListState extends ConsumerState<PapelList> {
  @override
  Widget build(BuildContext context) {
    final asyncPapeis = ref.watch(papelProvider);
    final papelNotifier = ref.read(papelProvider.notifier);

    return asyncPapeis.when(
      data: (papeis) {
        final filtered = widget.filter.isEmpty
            ? papeis
            : papeis
                .where((p) => p.descricao
                    .toLowerCase()
                    .contains(widget.filter.toLowerCase()))
                .toList();

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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Papel excluído')),
                );
              },
              child:
              PapelCard(papel: papel),
            );
          },
        );
      },
      loading: () => ListView.builder(
        itemCount: 5,
        itemBuilder: (_, __) => const ListTile(
          leading: CircleAvatar(backgroundColor: Colors.grey),
          title: SizedBox(height: 10, width: double.infinity, child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey))),
          subtitle: SizedBox(height: 10, width: double.infinity, child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey))),
        ),
      ),
      error: (err, stack) => Center(child: Text('Erro: $err')),
    );
  }
}
