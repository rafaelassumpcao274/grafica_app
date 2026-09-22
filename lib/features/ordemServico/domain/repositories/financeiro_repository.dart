import '../fatura_resumo_dto.dart';
import '../ordem_servico_financeiro_resumo_dto.dart';
import '../parcela_dto.dart';
import '../parcela_resumo_dto.dart';
import '../relatorio_mensal_dto.dart';

/// Quantidade máxima de parcelas permitida para uma fatura (regra de negócio: 1x a 7x).
const int kMaxParcelasFatura = 7;

abstract class FinanceiroRepository {
  Future<int> criarFatura({int? ordemServicoId, String? descricao, required double valorTotal});

  Future<List<FaturaResumoDto>> obterFaturasComTotais();

  Future<List<ParcelaDto>> obterParcelasVencidas(DateTime agora);

  /// Parcelas de uma fatura específica, com total recebido e saldo por parcela
  Future<List<ParcelaResumoDto>> obterParcelasPorFatura(int faturaId);

  Future<int> registrarRecebimento({required int parcelaId, required double valor, required DateTime dataPagamento, String? formaPagamento});

  Future<double> totalRecebidoNoMes(int year, int month);

  Future<double> totalDespesasNoMes(int year, int month);

  Future<RelatorioMensalDto> resultadoMensal(int year, int month);

  /// Cria fatura com múltiplas parcelas baseado em período de datas
  /// Retorna o ID da fatura criada
  Future<int> criarFaturaComParcelas({
    required int? ordemServicoId,
    required String? descricao,
    required double valorTotal,
    required DateTime dataEmissao,
    required DateTime dataVencimento,
    required int quantidadeParcelas,
  });

  /// Cria múltiplas faturas para uma ordem de serviço
  /// Cada fatura com valor dividido pela quantidade
  Future<List<int>> criarMultiplasFaturasParaOS({
    required int ordemServicoId,
    required int quantidadeFaturas,
    required double valorUnitario,
    required DateTime dataEmissao,
    String? descricao,
  });

  /// Vincula uma fatura existente a uma ordem de serviço
  Future<void> vincularFaturaAOS({
    required int faturaId,
    required int ordemServicoId,
  });

  /// Exclui uma fatura e todas as suas parcelas/recebimentos associados
  Future<void> deletarFatura(int faturaId);

  /// Resumo financeiro por Ordem de Serviço (Contratado / Faturado / Recebido)
  /// no período informado, com filtro opcional de drill-down por OS ou Fatura.
  Future<List<OrdemServicoFinanceiroResumoDto>> obterResumoFinanceiroPorOrdemServico({
    required DateTime periodoInicio,
    required DateTime periodoFim,
    int? ordemServicoId,
    int? faturaId,
  });

  /// Agregado de faturas sem OS vinculada, no período informado.
  Future<({double faturado, double recebido, int quantidade})> obterFaturamentoSemOrdemServico({
    required DateTime periodoInicio,
    required DateTime periodoFim,
  });
}
