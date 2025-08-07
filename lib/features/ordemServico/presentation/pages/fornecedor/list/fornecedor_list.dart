import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/enums/TipoServico.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/fornecedor_provider.dart';

import '../../../providers/clientes_provider_refactored.dart';
import '../edit/fornecedor_form_page.dart';


class FornecedorList extends ConsumerStatefulWidget {
  final String filter;
  const FornecedorList({super.key, this.filter = ''});

  static _FornecedorListState? of(BuildContext context) {
    final state = context.findAncestorStateOfType<_FornecedorListState>();
    return state;
  }

  @override
  ConsumerState<FornecedorList> createState() => _FornecedorListState();
}

class _FornecedorListState extends ConsumerState<FornecedorList> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final asyncNotifier = ref.watch(fornecedorProvider);
    final fornecedorNotifier = ref.read(fornecedorProvider.notifier);

    return asyncNotifier.when(
      data: (notifier) {
        final fornecedores = notifier;
        final filtered = widget.filter.isEmpty
            ? fornecedores
            : fornecedores.where((c) {
                final query = widget.filter.toLowerCase();
                return (c?.nome.toLowerCase().contains(query) ??
                        false) ||
                    (c?.email?.toLowerCase().contains(query) ?? false);
              }).toList();
        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final fornecedor = filtered[index];
            return Dismissible(
              key: Key(fornecedor.id ?? fornecedor.nome),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) async {
                await fornecedorNotifier.delete(fornecedor.id);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Fornecedor excluído')),
                );
              },
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(fornecedor.nome),
                  subtitle:
                      Text( fornecedor.tipoServico.label),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FornecedorForm(fornecedorId: fornecedor.id),
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
