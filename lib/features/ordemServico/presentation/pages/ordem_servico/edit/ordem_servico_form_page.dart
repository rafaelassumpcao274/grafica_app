import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/viaCoresOrdemServico.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/via_cores.dart';
import 'package:unilith_app/features/ordemServico/domain/vos/currency.dart';
import 'package:unilith_app/features/ordemServico/domain/vos/tamanho.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/components/fornecedor_custo_autocomplete.dart';
import 'package:unilith_app/features/ordemServico/presentation/widgets/via_cores/chips_via_cores.dart';

import '../../../../domain/entities/clientes.dart';
import '../../../../domain/entities/formato.dart';
import '../../../../domain/entities/ordemservico.dart';
import '../../../../domain/entities/papel.dart';
import '../../../providers/fornecedor_custo_provider.dart';
import '../../../providers/ordemservico_provider.dart';
import '../../../widgets/cliente/cliente_autocomplete.dart';
import '../../../widgets/components/custom_decimal_input.dart';
import '../../../widgets/components/custom_integer_input.dart';
import '../../../widgets/components/custom_switch.dart';
import '../../../widgets/components/custom_text_input.dart';
import '../../../widgets/components/formato_autocomplete.dart';
import '../../../widgets/components/papel_autocomplete.dart';
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
  final _papelController = TextEditingController();
  final _corFrenteController = TextEditingController();
  final _corVersoController = TextEditingController();
  final _formatoController = TextEditingController();
  final _quantidadeFolhaController = NumberEditingController<int>(value: 0);
  final _numeracaoInicialController = NumberEditingController<int>(value: 0);
  final _numeracaoFinalController = NumberEditingController<int>(value: 0);
  final _observacaoController = TextEditingController();
  final _valorCustoController = NumberEditingController<double>(value: 0.0);
  final _valorTotalController = NumberEditingController<double>(value: 0.0);
  final _tamanhoImagemController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Clientes? _selectedCliente;
  Formato? _selectedFormato;
  Papel? _selectedPapel;
  List<ViaCoresOrdemServico> _listVias = [];
  bool possuiNumeracao = false;

  @override
  void dispose() {
    _clienteController.dispose();
    _materialController.dispose();
    _papelController.dispose();
    _corFrenteController.dispose();
    _corVersoController.dispose();
    _quantidadeFolhaController.dispose();
    _numeracaoInicialController.dispose();
    _numeracaoFinalController.dispose();
    _observacaoController.dispose();
    _formatoController.dispose();
    _valorCustoController.dispose();
    _valorTotalController.dispose();
    _tamanhoImagemController.dispose();
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
        final fornecedorNotifier = ref.read(fornecedorCustoProvider.notifier);
        final fornecedores = ref.watch(fornecedorCustoProvider);
        final total = fornecedores.fold(0.0, (a, b) => a + b.custo);

        return asyncNotifier.when(
          data: (ordemServicoNotifier) {
            if (!_loaded && widget.ordemId != null) {
              _loaded = true;
              ordemNotifier.getById(widget.ordemId!).then((ordem) {
                ref.read(fornecedorCustoProvider.notifier).clear();
                ref.invalidate(fornecedorCustoProvider);
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
                    _selectedPapel = ordem.papel;
                    _papelController.text = ordem.papel?.descricao ?? '';
                    _formatoController.text = ordem.formato?.descricao ?? '';
                    _tamanhoImagemController.text =
                        ordem.tamanhoImagem != null ? ordem.tamanhoImagem.toString(): '';
                    _valorCustoController.text =
                        Currency(ordem.valorCusto.toString()).toString();
                    _valorTotalController.text =
                        Currency(ordem.valorTotal.toString()).toString();
                    _listVias = ordem.vias;
                    ref.invalidate(fornecedorCustoProvider);

                    if (ordem.fornecedores.isNotEmpty) {
                      ref
                          .read(fornecedorCustoProvider.notifier)
                          .setFornecedores(ordem.fornecedores);
                    }
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

                        Card(
                          margin: EdgeInsets.all(1),
                          elevation: 5,
                          child:
                          Padding(padding: EdgeInsetsGeometry.all(10),
                          child:
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: const  Text("Informação inicial", style: TextStyle(fontSize: 20 )),
                              ),

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
                                controller: _tamanhoImagemController,
                                hintText: 'Tamanho da Imagem',
                                icon: Icons.image,
                              ),

                            ],
                          ),

                          )
                        ),

                        const SizedBox(height: 16.0),

                        Card(
                            margin: EdgeInsets.all(1),
                            elevation: 5,
                            child:
                            Padding(padding: EdgeInsetsGeometry.all(10),
                              child:
                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: const Text("Cores", style: TextStyle(fontSize: 20),),
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
                                  ChipsInputVia(
                                    initialItems: _listVias.map((it) => it.viaCores!).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _listVias = value.map((it) => ViaCoresOrdemServico(viaCores: it)).toList();
                                      });
                                    },
                                  ),
                                ],
                              ),

                            )
                        ),

                        const SizedBox(height: 16.0),

                        Card(
                            margin: EdgeInsets.all(1),
                            elevation: 5,
                            child:
                            Padding(padding: EdgeInsetsGeometry.all(10),
                              child:
                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: const Text("Papeis", style: TextStyle(fontSize: 20),),
                                  ),

                                  const SizedBox(height: 16.0),

                                  PapelAutocomplete( controller: _papelController, onSelected: (papel) => _selectedPapel = papel,),
                                  const SizedBox(height: 16.0),
                                  CustomIntegerInput(
                                      controller: _quantidadeFolhaController,
                                      hintText: 'Quantidade de Folhas',
                                      icon: Icons.format_list_numbered),
                                  const SizedBox(height: 16.0),
                                  FormatoAutocomplete(
                                    initialValue: _selectedFormato,
                                    controller: _formatoController,
                                    onSelected: (formato) => _selectedFormato = formato,
                                  ),
                                ],
                              ),

                            )
                        ),
                        const SizedBox(height: 16.0),

                        Card(
                            margin: EdgeInsets.all(1),
                            elevation: 5,
                            child:
                            Padding(padding: EdgeInsetsGeometry.all(10),
                              child:
                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: const Text("Acabamento", style: TextStyle(fontSize: 20),),
                                  ),

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
                                ],
                              ),

                            )
                        ),

                        const SizedBox(height: 16.0),

                        Card(
                            margin: EdgeInsets.all(1),
                            elevation: 5,
                            child:
                            Padding(padding: EdgeInsetsGeometry.all(10),
                              child:
                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: const Text("Custos", style: TextStyle(fontSize: 20),),
                                  ),

                                  const SizedBox(height: 16.0),

                                  FornecedorCustoAutocomplete(),
                                  const SizedBox(height: 16.0),
                                  CustomDecimalInput(
                                    controller: _valorCustoController..text = Currency(total.toString()).toString(),
                                    hintText: 'Valor Custo',
                                    enabled: false,
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
                                ],
                              ),

                            )
                        ),

                        const SizedBox(height: 16.0),

                        Card(
                            margin: EdgeInsets.all(1),
                            elevation: 5,
                            child:
                            Padding(padding: EdgeInsetsGeometry.all(10),
                              child:
                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: const Text("Observação", style: TextStyle(fontSize: 20),),
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
                                ],
                              ),

                            )
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
                                final fornecedoresSelecionados =
                                    ref.read(fornecedorCustoProvider);
                                final ordem = OrdemServico(
                                    id: widget.ordemId,
                                    clientes: _selectedCliente,
                                    formato: _selectedFormato,
                                    papel: _selectedPapel,
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
                                    valorCusto: fornecedorNotifier.totalCusto,
                                    valorTotal:
                                        Currency(_valorTotalController.text)
                                            .toDouble(),
                                    fornecedores: fornecedoresSelecionados,
                                    vias: _listVias,
                                    tamanhoImagem: _tamanhoImagemController.text.isNotEmpty ? new Tamanho(
                                        _tamanhoImagemController.text): null);
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
