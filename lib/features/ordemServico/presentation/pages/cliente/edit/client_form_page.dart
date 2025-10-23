import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/components/custom_btn.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/components/custom_header_with_btn_back.dart';

import '../../../../domain/entities/clientes.dart';
import '../../../core/theme.dart';
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
        if(clienteId == null || clienteId!.isEmpty){
          viewModel.clearControllers();
        }

        if (viewModel.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.lightGray,
    body: SafeArea(child:
        Column(
          children: [
            CustomHeaderWithBtnBack(text: clienteId != null ? 'Editar Cliente' : 'Cadastrar Cliente'),
            Expanded(child:
                SingleChildScrollView(
                  padding: EdgeInsets.all(24),
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

                        CustomBtn( text: 'Salvar Cliente',
                            onTap: () async {
                              await viewModel.saveCliente(clienteId);
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),
                ),)
            )

          ],
        )
    )
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Erro: $err'))),
    );
  }
}
