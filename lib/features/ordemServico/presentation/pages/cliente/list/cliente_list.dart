import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/clientes_provider_refactored.dart';
import '../edit/client_form_page.dart';


class ClientList extends ConsumerStatefulWidget {
  final String filter;
  const ClientList({super.key, this.filter = ''});

  static _ClientListState? of(BuildContext context) {
    final state = context.findAncestorStateOfType<_ClientListState>();
    return state;
  }

  @override
  ConsumerState<ClientList> createState() => _ClientListState();
}

class _ClientListState extends ConsumerState<ClientList> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final clientesNotifierAsync = ref.watch(clientesNotifierProvider);

    return clientesNotifierAsync.when(
      data: (notifier) {
        final clientes = notifier.state;
        final filtered = widget.filter.isEmpty
            ? clientes
            : clientes.where((c) {
                final query = widget.filter.toLowerCase();
                return (c?.nomeEmpresa.toLowerCase().contains(query) ??
                        false) ||
                    (c?.documento.toLowerCase().contains(query) ?? false) ||
                    (c?.email?.toLowerCase().contains(query) ?? false);
              }).toList();
        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final cliente = filtered[index];
            return Dismissible(
              key: Key(cliente.id ?? cliente.nomeEmpresa),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) async {
                await notifier.deleteCliente(cliente.id);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cliente excluído')),
                );
              },
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(cliente.nomeEmpresa),
                  subtitle:
                      Text(cliente.getDocumentFormatted() ?? 'documento não informado'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClientForm(clienteId: cliente.id),
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
