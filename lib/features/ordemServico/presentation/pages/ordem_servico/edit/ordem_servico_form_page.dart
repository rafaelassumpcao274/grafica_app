import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../domain/entities/clientes.dart';
import '../../../../domain/entities/formato.dart';
import '../../../../domain/entities/ordemservico.dart';
import '../../../providers/ordemservico_provider.dart';
import '../../../widgets/cliente/cliente_autocomplete.dart';
import '../../../widgets/components/custom_decimal_input.dart';
import '../../../widgets/components/custom_integer_input.dart';
import '../../../widgets/components/custom_switch.dart';
import '../../../widgets/components/custom_text_input.dart';
import '../../../widgets/components/formato_autocomplete.dart';
import '../../../widgets/number_editing_controller.dart';

class OrdemServicoForm extends ConsumerStatefulWidget {
  final int? ordemId;
  const OrdemServicoForm({super.key, this.ordemId});

  @override
  ConsumerState<OrdemServicoForm> createState() => _OrdemServicoFormState();
}

class _OrdemServicoFormState extends ConsumerState<OrdemServicoForm> {
  final _formKey = GlobalKey<FormState>();
  final _clienteController = TextEditingController();
  final _materialController = TextEditingController();
  final _corFrenteController = TextEditingController();
  final _corVersoController = TextEditingController();
  final _formatoController = TextEditingController();
  final _quantidadeFolhaController = NumberEditingController<int>();
  final _numeracaoInicialController = NumberEditingController<int>();
  final _numeracaoFinalController = NumberEditingController<int>();
  final _observacaoController = TextEditingController();
  final _valorCustoController = NumberEditingController<double>();
  final _valorTotalController = NumberEditingController<double>();

  Clientes? _selectedCliente;
  Formato? _selectedFormato;
  bool possuiNumeracao = false;

  @override
  void dispose() {
    _clienteController.dispose();
    _materialController.dispose();
    _corFrenteController.dispose();
    _corVersoController.dispose();
    _quantidadeFolhaController.dispose();
    _numeracaoInicialController.dispose();
    _numeracaoFinalController.dispose();
    _observacaoController.dispose();
    _formatoController.dispose();
    _valorCustoController.dispose();
    _valorTotalController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final asyncNotifier = ref.watch(ordemServicoProvider);
        final ordemNotifier = ref.watch(ordemServicoProvider.notifier);
        return asyncNotifier.when(
          data: (ordemServicoNotifier) {
            if (!_loaded && widget.ordemId != null) {
              _loaded = true;
              ordemNotifier.getById(widget.ordemId!).then((ordem) {
                if (ordem != null) {
                  setState(() {
                    _materialController.text = ordem.material ?? '';
                    _corFrenteController.text = ordem.corFrente ?? '';
                    _corVersoController.text = ordem.corVerso ?? '';
                    _quantidadeFolhaController.text =
                        ordem.quantidadeFolha.toString();
                    _numeracaoInicialController.text =
                        ordem.numeracaoInicial.toString();
                    _numeracaoFinalController.text =
                        ordem.numeracaoFinal.toString();
                    _observacaoController.text = ordem.observacao ?? '';
                    possuiNumeracao = ordem.possuiNumeracao;
                    _selectedCliente = ordem.clientes;
                    _clienteController.text = ordem.clientes?.nomeEmpresa ?? '';
                    _selectedFormato = ordem.formato;
                    _formatoController.text = ordem.formato?.descricao ?? '';
                    _valorCustoController.text = ordem.valorCusto.toString();
                    _valorTotalController.text = ordem.valorTotal.toString();
                  });
                }
              });
            }

            return Scaffold(
              appBar: AppBar(
                title: Text(widget.ordemId != null
                    ? 'Editar Ordem de Serviço'
                    : 'Nova Ordem de Serviço'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClienteAutocomplete(
                          initialValue: _selectedCliente,
                          controller: _clienteController,
                          onSelected: (cliente) {
                            _selectedCliente = cliente;
                            _clienteController.text = cliente.nomeEmpresa;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextInput(
                          controller: _materialController,
                          hintText: 'Informe o material',
                          icon: Icons.receipt_long,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Informe o material';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextInput(
                          controller: _corFrenteController,
                          hintText: 'Cor Frente',
                          icon: Icons.color_lens,
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextInput(
                          controller: _corVersoController,
                          hintText: 'Cor Verso',
                          icon: Icons.color_lens,
                        ),
                        const SizedBox(height: 16.0),
                        FormatoAutocomplete(
                          initialValue: _selectedFormato,
                          controller: _formatoController,
                          onSelected: (formato) => _selectedFormato = formato,
                        ),
                        const SizedBox(height: 16.0),
                        CustomIntegerInput(
                            controller: _quantidadeFolhaController,
                            hintText: 'Quantidade de Folhas',
                            icon: Icons.format_list_numbered),
                        const SizedBox(height: 16.0),
                        CustomSwitch(
                          value: possuiNumeracao,
                          onChanged: (value) {
                            setState(() {
                              possuiNumeracao = value;
                            });
                          },
                          label: 'Possui numeração',
                        ),
                        if (possuiNumeracao) ...[
                          const SizedBox(height: 16.0),
                          CustomIntegerInput(
                            controller: _numeracaoInicialController,
                            hintText: 'Numeração Inicial',
                            icon: Icons.format_list_numbered,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Informe a numeração inicial';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Digite um número válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          CustomIntegerInput(
                            controller: _numeracaoFinalController,
                            hintText: 'Numeração Final',
                            icon: Icons.format_list_numbered,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Informe a numeração final';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Digite um número válido';
                              }
                              return null;
                            },
                          ),
                        ],
                        const SizedBox(height: 16.0),
                        CustomDecimalInput(
                          controller: _valorCustoController,
                          hintText: 'Valor Custo',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Informe um valor';
                            }

                            // Normaliza o valor: remove pontos e troca vírgula por ponto
                            final cleaned =
                                value.replaceAll('.', '').replaceAll(',', '.');
                            final parsed = double.tryParse(cleaned);

                            if (parsed == null) return 'Digite um valor válido';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        CustomDecimalInput(
                          controller: _valorTotalController,
                          hintText: 'Valor Total',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Informe um valor';
                            }

                            // Normaliza o valor: remove pontos e troca vírgula por ponto
                            final cleaned =
                                value.replaceAll('.', '').replaceAll(',', '.');
                            final parsed = double.tryParse(cleaned);

                            if (parsed == null) return 'Digite um valor válido';

                            return null;
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
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final ordem = OrdemServico(
                                  id: widget.ordemId ?? 0,
                                  clientes: _selectedCliente,
                                  formato: _selectedFormato,
                                  material: _materialController.text,
                                  corFrente: _corFrenteController.text,
                                  corVerso: _corVersoController.text,
                                  quantidadeFolha:
                                      _quantidadeFolhaController.number!,
                                  possuiNumeracao: possuiNumeracao,
                                  numeracaoInicial:
                                      _numeracaoInicialController.number!,
                                  numeracaoFinal:
                                      _numeracaoFinalController.number!,
                                  observacao: _observacaoController.text,
                                  valorCusto: _valorCustoController.number!, 
                                  valorTotal: _valorTotalController.number!, 
                                );
                                if (widget.ordemId != null) {
                                  await ordemNotifier.updateOS(ordem);
                                } else {
                                  await ordemNotifier.add(ordem);
                                }
                                Navigator.pop(context, ordem);
                              }
                            },
                            child: const Text(
                              'Salvar',
                              style: TextStyle(
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
