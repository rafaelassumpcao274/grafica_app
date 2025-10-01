import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/clientes.dart';
import '../../../providers/clientes_provider_refactored.dart';
import '../../../widgets/components/cpf_cnpj_form_field.dart';
import '../../../widgets/components/custom_text_input.dart';
import 'client_form_view_model.dart';

class ClientForm extends ConsumerWidget {
  final String? clienteId;

  const ClientForm({super.key, this.clienteId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clienteNotifierAsync = ref.watch(clientesNotifierProvider);

    return clienteNotifierAsync.when(
      data: (clienteNotifier) {
        final viewModel = ref.watch(clientFormViewModelProvider(clienteId));

        if (viewModel.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(clienteId != null ? 'Editar Cliente' : 'Cadastrar Cliente'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: GlobalKey<FormState>(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextInput(
                      controller: viewModel.nameController,
                      hintText: 'Nome da Empresa',
                      icon: Icons.domain,
                    ),
                    const SizedBox(height: 16),
                    CustomTextInput(
                      controller: viewModel.emailController,
                      hintText: 'E-mail',
                      icon: Icons.alternate_email,
                    ),
                    const SizedBox(height: 16),
                    CpfCnpjFormField(controller: viewModel.cpfController),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await viewModel.saveCliente(clienteId);
                          Navigator.pop(context);
                        },
                        child: Text(clienteId != null ? 'Salvar Alterações' : 'Salvar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Erro: $err'))),
    );
  }
}
