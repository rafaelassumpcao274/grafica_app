import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/enums/TipoServico.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/fornecedor_provider.dart';

import '../../../providers/clientes_provider_refactored.dart';
import '../edit/fornecedor_form_page.dart';
import 'fornecedor_list_view_model.dart';

class FornecedorList extends ConsumerStatefulWidget {
  final String filter;
  const FornecedorList({super.key, this.filter = ''});

  @override
  ConsumerState<FornecedorList> createState() => _FornecedorListState();
}

class _FornecedorListState extends ConsumerState<FornecedorList> {
  late final viewModel = FornecedorListViewModel(ref.read(fornecedorProvider.notifier));

  @override
  void initState() {
    super.initState();
    viewModel.loadFornecedores();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, _) {
        if (viewModel.isLoading) {
          // Skeleton/List placeholders
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                leading: Container(width: 40, height: 40, color: Colors.grey.shade300),
                title: Container(height: 16, color: Colors.grey.shade300),
                subtitle: Container(height: 12, margin: const EdgeInsets.only(top: 4), color: Colors.grey.shade200),
              ),
            ),
          );
        }

        if (viewModel.fornecedores.isEmpty) {
          return const Center(child: Text('Nenhum fornecedor encontrado'));
        }

        return ListView.builder(
          itemCount: viewModel.fornecedores.length,
          itemBuilder: (context, index) {
            final fornecedor = viewModel.fornecedores[index];
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
                        builder: (_) => FornecedorForm(fornecedorId: fornecedor.id),
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
