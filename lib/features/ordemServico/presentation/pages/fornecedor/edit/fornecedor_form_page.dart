import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/components/custom_btn.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/components/custom_obsevarcao_input.dart';
import '../../../providers/fornecedor_provider.dart';
import '../../../widgets/components/custom_text_input.dart';
import '../../../widgets/components/dropdown_tipo_servico.dart';
import '../../../widgets/components/telefone_input.dart';
import 'fornecedor_form_view_model.dart';

class FornecedorForm extends ConsumerWidget {
  final String? fornecedorId;

  const FornecedorForm({super.key, this.fornecedorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(fornecedorNotifierProvider);

    return notifier.when(
      data: (fornecedorNotifier) {
        final vm = ref.watch(fornecedorFormViewModelProvider(fornecedorId));

        if (fornecedorId == null || fornecedorId!.isEmpty) {
          vm.clearFields();
        }

        if (vm.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(fornecedorId != null
                ? 'Editar Fornecedor'
                : 'Cadastrar Fornecedor'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: GlobalKey<FormState>(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextInput(
                      controller: vm.nameController,
                      hintText: 'Nome do Fornecedor',
                      icon: Icons.business_center,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Informe o nome do Fornecedor';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextInput(
                      controller: vm.emailController,
                      hintText: 'E-mail',
                      icon: Icons.alternate_email,
                    ),
                    const SizedBox(height: 16),
                    CustomTextInput(
                      controller: vm.contatoController,
                      hintText: 'Contato',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 16),
                    TelefoneInput(controller: vm.telefoneController),
                    const SizedBox(height: 16),
                    TipoServicoDropdown(
                      valorInicial: vm.tipoSelecionado,
                      onChanged: (valor) => vm.tipoSelecionado = valor,
                    ),
                    const SizedBox(height: 16),
                    CustomObservacaoInput(controller: vm.observacaoController),
                    const SizedBox(height: 16),
                    CustomBtn(
                        text: 'Salvar',
                        onTap: () async {
                          await vm.saveFornecedor(fornecedorId);
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Erro: $err'))),
    );
  }
}
