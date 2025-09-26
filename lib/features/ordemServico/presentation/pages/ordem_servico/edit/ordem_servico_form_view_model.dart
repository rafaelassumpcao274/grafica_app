import 'package:flutter/material.dart';
import '../../../../domain/entities/clientes.dart';
import '../../../../domain/entities/formato.dart';
import '../../../../domain/entities/fornecedorOrdemServico.dart';
import '../../../../domain/entities/ordemservico.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/papel.dart';
import '../../../../domain/entities/viaCoresOrdemServico.dart';
import '../../../../domain/vos/tamanho.dart';
import '../../../providers/fornecedor_custo_provider.dart';
import '../../../providers/ordemservico_provider.dart';
import '../../../widgets/components/fornecedor_custo_autocomplete_view_model.dart';
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
    ref.listen<List<FornecedorOrdemServico>>(
      fornecedorCustoViewModelProvider,
          (previous, next) {
        final total = next.fold(0.0, (a, b) => a + b.custo);
        valorCustoController.text = total.toStringAsFixed(2);
        notifyListeners();
      },
    );
  }


  // Fornecedor
  FornecedorCustoViewModel get fornecedorNotifier =>
      ref.read(fornecedorCustoViewModelProvider.notifier);


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

    final fornecedorVM = fornecedorNotifier;
    fornecedorVM.clear();
   if(ordemId != null){
     final ordem = await ordemNotifier.getById(ordemId);
     if (ordem != null) {

       // Campos principais
       selectedCliente = ordem.clientes;
       selectedFormato = ordem.formato;
       selectedPapel = ordem.papel;
       listVias = ordem.vias;
       possuiNumeracao = ordem.possuiNumeracao;

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
       valorCustoController.text = ordem.valorCusto.toString();
       valorTotalController.text = ordem.valorTotal.toString();

       // Carrega fornecedores já salvos na OS

       if (ordem.fornecedores.isNotEmpty) {
         fornecedorVM.setFornecedores(ordem.fornecedores);
       }
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
  }

  OrdemServico buildOrdem({int? ordemId}) {
    final totalCusto = fornecedorNotifier.totalCusto;
    final fornecedores = fornecedorNotifier.state;

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
      valorTotal: valorTotalController.number!.toDouble(),
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
