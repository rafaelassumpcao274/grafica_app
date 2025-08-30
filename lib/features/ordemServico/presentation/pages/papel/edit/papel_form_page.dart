import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/fornecedor_provider.dart';
import 'package:unilith_app/features/ordemServico/presentation/providers/papel_provider.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/number_editing_controller.dart';

import '../../../../domain/entities/clientes.dart';
import '../../../../domain/entities/enums/TipoServico.dart' show TipoServico;
import '../../../../domain/entities/fornecedor.dart';
import '../../../../domain/entities/papel.dart';
import '../../../providers/clientes_provider_refactored.dart';
import '../../../widgets/components/custom_text_input.dart';
import '../../../widgets/components/dropdown_tipo_servico.dart';
import '../../../widgets/components/telefone_input.dart';


class PapelForm extends ConsumerStatefulWidget {
  final String? papelId;
  const PapelForm({super.key, this.papelId});

  @override
  ConsumerState<PapelForm> createState() => _PapelFormState();
}

class _PapelFormState extends ConsumerState<PapelForm> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  final _quantidadeController = NumberEditingController<int>();


  @override
  void dispose() {
    _descricaoController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadClienteIfEditing();
  }

  Future<void> _loadClienteIfEditing() async {
    if (widget.papelId != null) {
      final notifierAsync = ref.read(papelProvider.notifier);

      if (notifierAsync != null) {
        final papel = await notifierAsync.getById(widget.papelId!);
        if (papel != null) {
          _descricaoController.text = papel.descricao ?? '';
          _quantidadeController.text = papel.quantidadePapel.toString() ?? '0';

        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final asyncProvider = ref.watch(papelProvider);
        final notifierAsync = ref.read(papelProvider.notifier);
        return asyncProvider.when(
          data: (clienteNotifier) {
            if(widget.papelId != null) {
              if (notifierAsync != null) {
                notifierAsync.getById(widget.papelId!).then((papel) {
                  if (papel != null) {
                    setState(() {
                      _descricaoController.text = papel.descricao ?? '';
                      _quantidadeController.text = papel.quantidadePapel.toString() ?? '0';
                    });
                  }
                });
              }
            }
              return Scaffold(
                appBar: AppBar(
                  title: Text(widget.papelId != null
                      ? 'Editar Papel'
                      : 'Cadastrar Papel'),
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
                            controller: _descricaoController,
                            hintText: 'Nome do Papel',
                            icon: Icons.business_center,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Informe o nome do Papel';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          CustomTextInput(
                            controller: _quantidadeController,
                            hintText: 'E-mail',
                            icon: Icons.alternate_email,

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
                                  final papel = Papel(
                                      id: widget.papelId,
                                      descricao: _descricaoController.text,
                                      quantidadePapel: _quantidadeController.number!,
                                  );
                                  if (widget.papelId != null) {
                                    await notifierAsync.updatePapel(
                                        papel);
                                  } else {
                                    await notifierAsync.add(papel);
                                  }
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                widget.papelId != null
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
