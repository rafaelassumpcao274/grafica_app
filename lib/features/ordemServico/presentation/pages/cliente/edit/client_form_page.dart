import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/clientes.dart';
import '../../../providers/clientes_provider_refactored.dart';
import '../../../widgets/components/cpf_cnpj_form_field.dart';
import '../../../widgets/components/custom_text_input.dart';

class ClientForm extends ConsumerStatefulWidget {
  final String? clienteId;

  const ClientForm({super.key, this.clienteId});

  @override
  ConsumerState<ClientForm> createState() => _ClientFormState();
}

class _ClientFormState extends ConsumerState<ClientForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();
  final _cepController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    _cidadeController.dispose();
    _estadoController.dispose();
    _cepController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final notifierAsync = ref.watch(clientesNotifierProvider);
        return notifierAsync.when(
          data: (clienteNotifier) {

            if (widget.clienteId != null) {
              final notifierAsync = ref.read(clientesNotifierProvider);
              final clienteNotifier = notifierAsync.value;
              if (clienteNotifier != null) {
                clienteNotifier.getClienteById(widget.clienteId!).then( (cliente) => {

                  if (cliente != null) {
                    _nameController.text = cliente.nomeEmpresa ?? '',
                    _emailController.text = cliente.email ?? '',
                    _cpfController.text = cliente.getDocumentFormatted() ?? '',
                    _telefoneController.text = cliente.telefone ?? '1',
                }
                });

              }
            }


            return Scaffold(
              appBar: AppBar(
                title: Text(widget.clienteId != null
                    ? 'Editar Cliente'
                    : 'Cadastrar Cliente'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextInput(
                          controller: _nameController,
                          hintText: 'Nome da Empresa',
                          icon: Icons.domain,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Informe o nome da empresa';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextInput(
                          controller: _emailController,
                          hintText: 'E-mail',
                          icon: Icons.alternate_email,
                        ),
                        const SizedBox(height: 16.0),
                        CpfCnpjFormField(
                          controller: _cpfController,
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xD818971C),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final cliente = Clientes(
                                  id: widget.clienteId,
                                  nomeEmpresa: _nameController.text,
                                  email: _emailController.text,
                                  documento: _cpfController.text,
                                  telefone: _telefoneController.text,
                                  contato: _telefoneController.text,
                                );
                                if (widget.clienteId != null) {
                                  await clienteNotifier.updateCliente(cliente);
                                } else {
                                  await clienteNotifier.addCliente(cliente);
                                }
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              widget.clienteId != null
                                  ? 'Salvar Alterações'
                                  : 'Salvar',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Erro: $err')),
        );
      },
    );
  }
}
