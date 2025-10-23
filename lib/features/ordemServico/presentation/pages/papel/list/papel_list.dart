
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/papel/list/papel_list_view_model.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/papel_card.dart';

import '../edit/papel_form_page.dart';

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
  String searchQuery = '';

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   ref.read(papelListViewModelProvider).loadPapeis();
  // }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(papelListViewModelProvider);

    final filtered = widget.filter.isEmpty
        ? viewModel.papeis
        : viewModel.filter(widget.filter);

    if (viewModel.isLoading) {
      return ListView.builder(
        itemCount: 5,
        itemBuilder: (_, __) => const ListTile(
          leading: CircleAvatar(backgroundColor: Colors.grey),
          title: SizedBox(height: 10, width: double.infinity, child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey))),
          subtitle: SizedBox(height: 10, width: double.infinity, child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey))),
        ),
      );
    }

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
            await viewModel.deletePapel(papel.id);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Papel excluído')),
            );
          },
          child:
          PapelCard(papel: papel),
        );
      },
    );
  }
}
