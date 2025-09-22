import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/enums/TipoServico.dart';
import 'package:unilith_app/features/ordemServico/presentation/pages/fornecedor/edit/fornecedor_form_view_model.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/fornecedor_provider.dart';

import '../../../providers/clientes_provider_refactored.dart';
import '../edit/fornecedor_form_page.dart';
import 'fornecedor_list_view_model.dart';

class FornecedorList extends ConsumerWidget {
  final String filter;

  const FornecedorList({super.key, this.filter = ''});

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
    final fornecedoresAsync = ref.watch(fornecedorNotifierProvider);
    final fornecedorNotifier = ref.read(fornecedorNotifierProvider.notifier);

    return fornecedoresAsync.when(
      data: (fornecedores) {
        // cria o viewModel baseado na lista atual
        final viewModel =
        ref.watch(fornecedorListViewModelProvider(fornecedorNotifier));

        // Aplica filtro se necessário
        var listaFiltrada = fornecedores;
        if (filter.isNotEmpty) {
          viewModel.applyFilter(filter);
          listaFiltrada = viewModel.fornecedores;
        }

        if (viewModel.isLoading) {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: _buildSkeletonItem(),
            ),
          );
        }

        if (listaFiltrada.isEmpty) {
          return const Center(child: Text('Nenhum fornecedor encontrado'));
        }

        return ListView.builder(
          itemCount: listaFiltrada.length,
          itemBuilder: (context, index) {
            final fornecedor = listaFiltrada[index];
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
                await viewModel.deleteFornecedor(fornecedor.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fornecedor excluído')),
                );
              },
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.business),
                  title: Text(fornecedor.nome),
                  subtitle: Text(fornecedor.tipoServico.label),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            FornecedorForm(fornecedorId: fornecedor.id),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      loading: () =>
          ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) =>
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: _buildSkeletonItem(),
                ),
          ),
      error: (err, stack) => Center(child: Text('Erro: $err')),
    );
  }

}
