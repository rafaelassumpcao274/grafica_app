import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/fornecedor_provider.dart';

import '../../../../domain/entities/clientes.dart';
import '../../../../domain/entities/enums/TipoServico.dart' show TipoServico;
import '../../../../domain/entities/fornecedor.dart';
import '../../../providers/clientes_provider_refactored.dart';
import '../../../widgets/components/custom_text_input.dart';
import '../../../widgets/components/dropdown_tipo_servico.dart';
import '../../../widgets/components/telefone_input.dart';


class FornecedorForm extends ConsumerStatefulWidget {
  final String? fornecedorId;
  const FornecedorForm({super.key, this.fornecedorId});

  @override
  ConsumerState<FornecedorForm> createState() => _FornecedorFormState();
}

class _FornecedorFormState extends ConsumerState<FornecedorForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contatoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _observacaoController = TextEditingController();
  TipoServico? tipoSelecionado;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _contatoController.dispose();
    _telefoneController.dispose();
    _observacaoController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadClienteIfEditing();
  }

  Future<void> _loadClienteIfEditing() async {
    if (widget.fornecedorId != null) {
      final notifierAsync = ref.read(fornecedorProvider.notifier);

      if (notifierAsync != null) {
        final fornecedor = await notifierAsync.getById(widget.fornecedorId!);
        if (fornecedor != null) {
          _nameController.text = fornecedor.nome ?? '';
          _emailController.text = fornecedor.email ?? '';
          _contatoController.text = fornecedor.contato ?? '';
          _telefoneController.text = fornecedor.telefone ?? '';
          _observacaoController.text = fornecedor.observacao ?? '';
          tipoSelecionado = fornecedor.tipoServico;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final asyncProvider = ref.watch(fornecedorProvider);
        final notifierAsync = ref.read(fornecedorProvider.notifier);
        return asyncProvider.when(
          data: (clienteNotifier) {
            if(widget.fornecedorId != null) {
              if (notifierAsync != null) {
                notifierAsync.getById(widget.fornecedorId!).then((fornecedor) {
                  if (fornecedor != null) {
                    setState(() {
                      _nameController.text = fornecedor.nome ?? '';
                      _emailController.text = fornecedor.email ?? '';
                      _contatoController.text = fornecedor.contato ?? '';
                      _telefoneController.text = fornecedor.telefone ?? '';
                      _observacaoController.text = fornecedor.observacao ?? '';
                      tipoSelecionado = fornecedor.tipoServico;
                    });
                  }
                });
              }
            }
              return Scaffold(
                appBar: AppBar(
                  title: Text(widget.fornecedorId != null
                      ? 'Editar Fornecedor'
                      : 'Cadastrar Fornecedor'),
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
                            hintText: 'Nome do Fornecedor',
                            icon: Icons.business_center,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Informe o nome do Fornecedor';
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
                          CustomTextInput(
                            controller: _contatoController,
                            hintText: 'Contato',
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 16.0),
                          TelefoneInput(
                            controller: _telefoneController,
                          ),
                          const SizedBox(height: 16.0),
                          TipoServicoDropdown(
                            valorInicial: tipoSelecionado,
                            onChanged: (valor) {
                              setState(() {
                                tipoSelecionado = valor;
                              });
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Observação',
                              border: OutlineInputBorder(),
                            ),
                            controller: _observacaoController,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xD818971C),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final fornecedor = Fornecedor(
                                      id: widget.fornecedorId,
                                      nome: _nameController.text,
                                      email: _emailController.text,
                                      observacao: _observacaoController.text,
                                      telefone: _telefoneController.text,
                                      contato: _contatoController.text,
                                      tipoServico: tipoSelecionado ??
                                          TipoServico.distribuidora
                                  );
                                  if (widget.fornecedorId != null) {
                                    await notifierAsync.updateFornecedor(
                                        fornecedor);
                                  } else {
                                    await notifierAsync.add(fornecedor);
                                  }
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                widget.fornecedorId != null
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
