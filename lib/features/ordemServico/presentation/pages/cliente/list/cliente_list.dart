import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../edit/client_form_page.dart';
import '../../../providers/clientes_provider_refactored.dart';
import 'cliente_list_view_model.dart';

class ClientList extends ConsumerWidget {
  final String filter;

  const ClientList({super.key, this.filter = ''});

  Widget _buildSkeletonItem() {
    return Card(
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
        ),
        title: Container(
          width: double.infinity,
          height: 16,
          color: Colors.grey[300],
        ),
        subtitle: Container(
          width: 150,
          height: 14,
          color: Colors.grey[200],
          margin: const EdgeInsets.only(top: 8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientesNotifierAsync = ref.watch(clientesNotifierProvider);
    final clienteNotifier = ref.read(clientesNotifierProvider.notifier);
    final viewModel = ref.watch(clientListViewModelProvider(clienteNotifier));
    if(filter.isNotEmpty){
      viewModel.applyFilter(filter);
    }

    return clientesNotifierAsync.when(
      loading: () => ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: _buildSkeletonItem(),
        ),
      ),
      error: (err, stack) => Center(child: Text('Erro: $err')),
      data: (clientes) {
        // Agora temos certeza que o notifier não é nulo


        if (viewModel.isLoading) {
          // Skeleton enquanto o viewmodel carrega os dados
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: _buildSkeletonItem(),
            ),
          );
        }

        var filtered = clientes;
        if (filtered.isEmpty) {
          return const Center(child: Text('Nenhum Cliente encontrado'));
        }

        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final cliente = filtered[index];

            return Dismissible(
              key: Key(cliente.id ),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) async {
                await viewModel.deleteCliente(cliente.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cliente excluído')),
                );
              },
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(cliente.nomeEmpresa),
                  subtitle: Text(cliente.getDocumentFormatted() ?? 'documento não informado'),
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
    );
  }
}
