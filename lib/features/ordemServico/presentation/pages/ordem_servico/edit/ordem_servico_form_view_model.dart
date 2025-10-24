import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/clientes.dart';
import '../../../../domain/entities/formato.dart';
import '../../../../domain/entities/fornecedor_ordem_servico.dart';
import '../../../../domain/entities/ordemservico.dart';
import '../../../../domain/entities/papel.dart';
import '../../../../domain/entities/via_cores_ordem_servico.dart';
import '../../../../domain/vos/tamanho.dart';
import '../../../providers/ordemservico_provider.dart';
import '../../../widgets/fornecedor/fornecedor_custo_controller.dart';
import '../../../widgets/number_editing_controller.dart';

final ordemServicoViewModelProvider =
ChangeNotifierProvider.autoDispose<OrdemServicoViewModel>((ref) {
  final ordemNotifier = ref.read(ordemServicoProvider.notifier);
  return OrdemServicoViewModel(ordemNotifier, ref);
});

class OrdemServicoViewModel extends ChangeNotifier {
  final OrdemServicoNotifier ordemNotifier;
  final Ref ref;

  OrdemServicoViewModel(this.ordemNotifier, this.ref) {
    fornecedorCustoController.addListener( () => valorCustoController.text = fornecedorCustoController.totalCusto.toString());
  }


  // Campos e controllers
  Clientes? selectedCliente;
  Formato? selectedFormato;
  Papel? selectedPapel;
  List<ViaCoresOrdemServico> listVias = [];
  bool possuiNumeracao = false;

  TextEditingController materialController = TextEditingController();
  TextEditingController corFrenteController = TextEditingController();
  TextEditingController corVersoController = TextEditingController();
  TextEditingController formatoController = TextEditingController();
  TextEditingController papelController = TextEditingController();
  TextEditingController tamanhoImagemController = TextEditingController();
  TextEditingController observacaoController = TextEditingController();
  FornecedorCustoController fornecedorCustoController = FornecedorCustoController();

  NumberEditingController<int> quantidadeFolhaController =
  NumberEditingController<int>(value: 0);
  NumberEditingController<int> numeracaoInicialController =
  NumberEditingController<int>(value: 0);
  NumberEditingController<int> numeracaoFinalController =
  NumberEditingController<int>(value: 0);
  NumberEditingController<double> valorCustoController =
  NumberEditingController<double>(value: 0.0);
  NumberEditingController valorTotalController = NumberEditingController<double>(value: 0.0);

  bool isLoading = false;

  Future<void> loadOrdem(int? ordemId) async {
    isLoading = true;
    notifyListeners();

   if(ordemId != null){
     final ordem = await ordemNotifier.getById(ordemId);
     if (ordem != null) {

       // Campos principais
       selectedCliente = ordem.clientes;
       selectedFormato = ordem.formato;
       selectedPapel = ordem.papel;
       listVias = ordem.vias;
       possuiNumeracao = ordem.possuiNumeracao;
       fornecedorCustoController.setFornecedores( ordem.fornecedores);
       materialController.text = ordem.material ?? '';
       corFrenteController.text = ordem.corFrente ?? '';
       corVersoController.text = ordem.corVerso ?? '';
       quantidadeFolhaController.text = ordem.quantidadeFolha.toString();
       numeracaoInicialController.text = ordem.numeracaoInicial.toString();
       numeracaoFinalController.text = ordem.numeracaoFinal.toString();
       formatoController.text = ordem.formato?.descricao ?? '';
       papelController.text = ordem.papel?.descricao ?? '';
       tamanhoImagemController.text = ordem.tamanhoImagem?.toString() ?? '';
       observacaoController.text = ordem.observacao ?? '';
       valorCustoController.text = fornecedorCustoController.totalCusto.toString();
       valorTotalController.text = ordem.valorTotal.toString();
     }
   }

    isLoading = false;
    notifyListeners();
  }



  void disposeControllers() {
    materialController.dispose();
    corFrenteController.dispose();
    corVersoController.dispose();
    formatoController.dispose();
    papelController.dispose();
    tamanhoImagemController.dispose();
    valorTotalController.dispose();
    observacaoController.dispose();
    quantidadeFolhaController.dispose();
    numeracaoInicialController.dispose();
    numeracaoFinalController.dispose();
    valorCustoController.dispose();
    fornecedorCustoController.dispose();
  }

  OrdemServico buildOrdem({int? ordemId}) {
    final totalCusto = fornecedorCustoController.totalCusto;
    final fornecedores = fornecedorCustoController.value;

    return OrdemServico(
      id: ordemId,
      clientes: selectedCliente,
      formato: selectedFormato,
      papel: selectedPapel,
      material: materialController.text,
      corFrente: corFrenteController.text,
      corVerso: corVersoController.text,
      quantidadeFolha: quantidadeFolhaController.number!,
      possuiNumeracao: possuiNumeracao,
      numeracaoInicial: numeracaoInicialController.number!,
      numeracaoFinal: numeracaoFinalController.number!,
      observacao: observacaoController.text,
      valorCusto: totalCusto,
      valorTotal: double.tryParse(valorTotalController.text) ?? 0.0,
      fornecedores: fornecedores,
      vias: listVias,
      tamanhoImagem: tamanhoImagemController.text.isNotEmpty
          ? Tamanho(tamanhoImagemController.text)
          : null,
    );
  }

  Future<void> saveOrdem(){

    OrdemServico os = buildOrdem(ordemId: null);

    return ordemNotifier.add(os);
  }

  Future<void> updateOrdem(int ordemId){

    OrdemServico os = buildOrdem(ordemId: ordemId);

    return ordemNotifier.updateOS(os);
  }

}
