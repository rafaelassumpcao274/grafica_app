import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/ordemservico.dart';
import '../../../domain/provider/providers.dart';
import '../../../domain/repositories/financeiro_repository.dart' show kMaxParcelasFatura;
import '../../core/parcel_calculator.dart';



final faturaViewModelProvider =
    ChangeNotifierProvider.autoDispose<FaturaViewModel>((ref) {
  return FaturaViewModel(ref);
});

enum ParcelMode { byDate, byInstallments }

class FaturaViewModel extends ChangeNotifier {
  final Ref ref;

  FaturaViewModel(this.ref);

  // =================== ESTADO ===================
  List<ParcelaPreview> previewParcelas = [];

  bool isLoading = false;
  String? errorMessage;

  // =================== MODO DE PARCELAMENTO ===================
  ParcelMode parcelMode = ParcelMode.byDate;

  // =================== CAMPOS - MODO POR DATA ===================
  DateTime? dataFatura;
  DateTime? dataVencimento;

  // =================== CAMPOS - MODO POR PARCELAS ===================
  int quantidadeParcelas = 1;
  DateTime? dataPrimeiraParcela;

  // =================== CAMPO COMUM ===================
  double valorTotal = 0.0;
  OrdemServico? selectedOS;

  // =================== MÉTODOS ===================

  /// Alterna modo de parcelamento e limpa dados
  void toggleParcelMode(ParcelMode mode) {
    parcelMode = mode;
    previewParcelas.clear();
    errorMessage = null;
    notifyListeners();
  }

  /// Seleciona uma ordem de serviço e assume o valor total dela como
  /// valor da fatura
  void selectOrdenServico(OrdemServico os) {
    selectedOS = os;
    valorTotal = os.valorTotal;
    notifyListeners();
  }

  /// Limpa a ordem de serviço selecionada
  void clearSelectedOS() {
    selectedOS = null;
    notifyListeners();
  }

  /// Atualiza valor total e recalcula o preview das parcelas, se possível
  void setValorTotal(double valor) {
    valorTotal = valor;
    _recalculatePreview();
  }

  /// Atualiza a data da fatura (modo Por Data) e recalcula o preview se a
  /// data de vencimento já tiver sido informada
  void setDataFatura(DateTime data) {
    dataFatura = data;
    if (dataVencimento != null && !dataVencimento!.isAfter(data)) {
      // Vencimento deixou de ser válido para a nova data de emissão
      dataVencimento = null;
      previewParcelas.clear();
      errorMessage =
          'Data de vencimento deve ser após a data da fatura. Selecione novamente.';
      notifyListeners();
      return;
    }
    _recalculatePreview();
  }

  /// Recalcula o preview das parcelas com base no modo e nos dados já
  /// informados. Deve ser chamado sempre que quantidade, datas ou valor
  /// total forem alterados, para manter o preview sempre em sincronia.
  void _recalculatePreview() {
    if (parcelMode == ParcelMode.byDate) {
      if (dataFatura != null && dataVencimento != null) {
        calculateByDate(dataFatura!, dataVencimento!);
        return;
      }
    } else {
      if (dataPrimeiraParcela != null) {
        calculateByInstallments(quantidadeParcelas, dataPrimeiraParcela!);
        return;
      }
    }
    notifyListeners();
  }

  /// Calcula preview de parcelas (modo Por Data)
  void calculateByDate(DateTime emissao, DateTime vencimento) {
    if (valorTotal <= 0) {
      errorMessage = 'Valor total deve ser maior que zero';
      previewParcelas.clear();
      notifyListeners();
      return;
    }

    dataFatura = emissao;
    dataVencimento = vencimento;
    errorMessage = null;

    try {
      final parcelas = ParcelCalculator.calculateByDate(
        dataEmissao: emissao,
        dataVencimento: vencimento,
        valorTotal: valorTotal,
      );

      if (parcelas.length > kMaxParcelasFatura) {
        errorMessage =
            'O período escolhido geraria ${parcelas.length} parcelas. Máximo permitido: $kMaxParcelasFatura';
        previewParcelas.clear();
      } else {
        previewParcelas = parcelas;
      }
    } catch (e) {
      errorMessage = 'Erro ao calcular parcelas: $e';
      previewParcelas.clear();
    }

    notifyListeners();
  }

  /// Atualiza a quantidade de parcelas (modo Por Parcelas) e recalcula o
  /// preview se a data da primeira parcela já tiver sido informada
  void setQuantidadeParcelas(int quantidade) {
    quantidadeParcelas = quantidade;
    if (dataPrimeiraParcela != null) {
      calculateByInstallments(quantidade, dataPrimeiraParcela!);
    } else {
      notifyListeners();
    }
  }

  /// Calcula preview de parcelas (modo Por Parcelas)
  void calculateByInstallments(int quantidade, DateTime dataPrimeira) {
    if (valorTotal <= 0) {
      errorMessage = 'Valor total deve ser maior que zero';
      previewParcelas.clear();
      notifyListeners();
      return;
    }

    if (quantidade <= 0) {
      errorMessage = 'Quantidade de parcelas deve ser maior que zero';
      previewParcelas.clear();
      notifyListeners();
      return;
    }

    if (quantidade > kMaxParcelasFatura) {
      errorMessage = 'Máximo de $kMaxParcelasFatura parcelas';
      previewParcelas.clear();
      notifyListeners();
      return;
    }

    quantidadeParcelas = quantidade;
    dataPrimeiraParcela = dataPrimeira;
    errorMessage = null;

    try {
      previewParcelas = ParcelCalculator.calculateByInstallments(
        quantidadeParcelas: quantidade,
        dataPrimeiraParcela: dataPrimeira,
        valorTotal: valorTotal,
      );
    } catch (e) {
      errorMessage = 'Erro ao calcular parcelas: $e';
      previewParcelas.clear();
    }

    notifyListeners();
  }

  /// Cria fatura com parcelas (modo Por Data)
  Future<void> createInvoiceByDate({
    required int? ordemServicoId,
    String? descricao,
  }) async {
    if (dataFatura == null || dataVencimento == null) {
      errorMessage = 'Selecione as datas';
      notifyListeners();
      return;
    }

    if (previewParcelas.isEmpty) {
      errorMessage = 'Nenhuma parcela calculada';
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final financeiroRepository =
          await ref.watch(financeiroRepositoryProvider.future);

      await financeiroRepository.criarFaturaComParcelas(
        ordemServicoId: ordemServicoId,
        descricao: descricao,
        valorTotal: valorTotal,
        dataEmissao: dataFatura!,
        dataVencimento: dataVencimento!,
        quantidadeParcelas: previewParcelas.length,
      );

      // Limpa formulário após sucesso
      _resetForm();
    } catch (e) {
      errorMessage = 'Erro ao criar fatura: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Cria fatura com parcelas (modo Por Parcelas)
  Future<void> createInvoiceByInstallments({
    required int? ordemServicoId,
    String? descricao,
  }) async {
    if (dataPrimeiraParcela == null) {
      errorMessage = 'Selecione a data da primeira parcela';
      notifyListeners();
      return;
    }

    if (previewParcelas.isEmpty) {
      errorMessage = 'Nenhuma parcela calculada';
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final financeiroRepository =
          await ref.watch(financeiroRepositoryProvider.future);

      await financeiroRepository.criarFaturaComParcelas(
        ordemServicoId: ordemServicoId,
        descricao: descricao,
        valorTotal: valorTotal,
        dataEmissao: dataPrimeiraParcela!,
        dataVencimento: dataPrimeiraParcela!,
        quantidadeParcelas: previewParcelas.length,
      );

      // Limpa formulário após sucesso
      _resetForm();
    } catch (e) {
      errorMessage = 'Erro ao criar fatura: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Vincula fatura existente a uma ordem de serviço
  Future<void> linkInvoiceToOS({
    required int faturaId,
    required int ordemServicoId,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final financeiroRepository =
          await ref.watch(financeiroRepositoryProvider.future);

      await financeiroRepository.vincularFaturaAOS(
        faturaId: faturaId,
        ordemServicoId: ordemServicoId,
      );
    } catch (e) {
      errorMessage = 'Erro ao vincular fatura: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Limpa o formulário
  void _resetForm() {
    dataFatura = null;
    dataVencimento = null;
    dataPrimeiraParcela = null;
    quantidadeParcelas = 1;
    valorTotal = 0.0;
    selectedOS = null;
    previewParcelas.clear();
    errorMessage = null;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
