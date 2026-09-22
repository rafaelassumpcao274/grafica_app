import 'package:drift/drift.dart';
import 'package:unilith_app/features/ordemServico/data/local/app_database.dart';
import '../tables/fatura_table.dart';
import '../tables/parcela_table.dart';
import '../tables/recebimento_table.dart';
import '../tables/despesa_table.dart';
import '../tables/forma_pagamento_table.dart';

part 'finance_dao.g.dart';

@DriftAccessor(tables: [FaturaTable, ParcelaTable, RecebimentoTable, DespesaTable, FormaPagamentoTable])
class FinanceDao extends DatabaseAccessor<AppDatabase> with _$FinanceDaoMixin {
  FinanceDao(AppDatabase db) : super(db);

  Future<int> insertFatura(Insertable<FaturaTableData> f) => into(faturaTable).insert(f);
  Future<List<FaturaTableData>> getAllFaturas() => select(faturaTable).get();

  Future<int> insertParcela(Insertable<ParcelaTableData> p) => into(parcelaTable).insert(p);
  Future<List<ParcelaTableData>> parcelasByFatura(int faturaId) => (select(parcelaTable)..where((t) => t.faturaId.equals(faturaId))).get();

  Future<int> insertRecebimento(Insertable<RecebimentoTableData> r) => into(recebimentoTable).insert(r);
  Future<List<RecebimentoTableData>> recebimentosByParcela(int parcelaId) => (select(recebimentoTable)..where((t) => t.parcelaId.equals(parcelaId))).get();

  Future<int> insertDespesa(Insertable<DespesaTableData> d) => into(despesaTable).insert(d);

  Future<List<Map<String, Object?>>> faturasComTotais() async {
    final result = await customSelect('''
      SELECT f.*, 
        IFNULL(SUM(r.valor), 0) AS total_recebido,
        (f.valor_total - IFNULL(SUM(r.valor), 0)) AS saldo,
        c.nome_empresa AS cliente_nome,
        COALESCE(os.id || ' - ' || os.material, NULL) AS os_numero_material
      FROM fatura_table f
      LEFT JOIN parcela_table p ON p.fatura_id = f.id
      LEFT JOIN recebimento_table r ON r.parcela_id = p.id
      LEFT JOIN ordem_servico_table os ON os.id = f.ordem_servico_id
      LEFT JOIN clientes_table c ON c.id = os.cliente_id
      GROUP BY f.id
    ''').get();

    return result.map((r) => r.data).toList();
  }

  Future<List<ParcelaTableData>> parcelasVencidas(DateTime now) {
    return (select(parcelaTable)..where((p) => p.status.equals('ABERTA') & p.vencimento.isSmallerThanValue(now.millisecondsSinceEpoch))).get();
  }

  Future<List<Map<String, Object?>>> parcelasComTotaisPorFatura(int faturaId) async {
    final result = await customSelect('''
      SELECT p.*,
        IFNULL(SUM(r.valor), 0) AS total_recebido,
        (p.valor - IFNULL(SUM(r.valor), 0)) AS saldo
      FROM parcela_table p
      LEFT JOIN recebimento_table r ON r.parcela_id = p.id
      WHERE p.fatura_id = ?
      GROUP BY p.id
      ORDER BY p.numero
    ''', variables: [Variable<int>(faturaId)]).get();

    return result.map((r) => r.data).toList();
  }

  /// Resumo financeiro por Ordem de Serviço: Contratado (OS.valorTotal) vs.
  /// Faturado (soma valor_total das faturas da OS) vs. Recebido (soma dos
  /// recebimentos dessas faturas), no período informado.
  ///
  /// Período ancorado em fatura.created_at (epoch em MILISSEGUNDOS). O gate
  /// de período da própria OS usa ordem_servico_table.created_at, que é um
  /// DateTimeColumn nativo do drift armazenado em epoch em SEGUNDOS — por
  /// isso os limites são convertidos separadamente para cada tabela.
  ///
  /// Quando [ordemServicoId] ou [faturaId] são informados (drill-down), o
  /// gate de período da OS é ignorado, para que a OS/fatura escolhida não
  /// desapareça da lista por ter created_at fora do intervalo selecionado.
  Future<List<Map<String, Object?>>> resumoFinanceiroPorOrdemServico({
    required DateTime periodoInicio,
    required DateTime periodoFim,
    int? ordemServicoId,
    int? faturaId,
  }) async {
    final inicioMs = periodoInicio.millisecondsSinceEpoch;
    final fimMs = periodoFim.millisecondsSinceEpoch;
    final inicioSeg = inicioMs ~/ 1000;
    final fimSeg = fimMs ~/ 1000;

    final result = await customSelect('''
      WITH fatura_totais AS (
        SELECT f.id AS fatura_id, f.ordem_servico_id AS ordem_servico_id,
               f.valor_total AS valor_total, IFNULL(SUM(r.valor), 0) AS total_recebido
        FROM fatura_table f
        LEFT JOIN parcela_table p ON p.fatura_id = f.id
        LEFT JOIN recebimento_table r ON r.parcela_id = p.id
        WHERE f.created_at >= ? AND f.created_at <= ?
          AND (? IS NULL OR f.id = ?)
        GROUP BY f.id
      )
      SELECT os.id AS ordem_servico_id, os.material AS material, os.valor_total AS contratado,
             os.created_at AS os_created_at, c.nome_empresa AS cliente_nome,
             COUNT(ft.fatura_id) AS quantidade_faturas,
             IFNULL(SUM(ft.valor_total), 0) AS faturado,
             IFNULL(SUM(ft.total_recebido), 0) AS recebido
      FROM ordem_servico_table os
      LEFT JOIN clientes_table c ON c.id = os.cliente_id
      LEFT JOIN fatura_totais ft ON ft.ordem_servico_id = os.id
      WHERE (? IS NOT NULL OR (os.created_at >= ? AND os.created_at <= ?))
        AND (? IS NULL OR os.id = ?)
      GROUP BY os.id
      ORDER BY os.created_at DESC
    ''', variables: [
      Variable<int>(inicioMs),
      Variable<int>(fimMs),
      Variable<int>(faturaId),
      Variable<int>(faturaId),
      Variable<int>(ordemServicoId),
      Variable<int>(inicioSeg),
      Variable<int>(fimSeg),
      Variable<int>(ordemServicoId),
      Variable<int>(ordemServicoId),
    ]).get();

    return result.map((r) => r.data).toList();
  }

  /// Agregado de faturas sem OS vinculada, no período informado (para
  /// reconciliar o total do relatório por OS, que não inclui essas faturas).
  Future<Map<String, Object?>> faturamentoSemOrdemServico({
    required DateTime periodoInicio,
    required DateTime periodoFim,
  }) async {
    final row = await customSelect('''
      SELECT IFNULL(SUM(f.valor_total), 0) AS faturado,
             IFNULL(SUM(ft.total_recebido), 0) AS recebido,
             COUNT(*) AS quantidade
      FROM fatura_table f
      LEFT JOIN (
        SELECT p.fatura_id AS fatura_id, SUM(r.valor) AS total_recebido
        FROM parcela_table p
        LEFT JOIN recebimento_table r ON r.parcela_id = p.id
        GROUP BY p.fatura_id
      ) ft ON ft.fatura_id = f.id
      WHERE f.ordem_servico_id IS NULL
        AND f.created_at >= ? AND f.created_at <= ?
    ''', variables: [
      Variable<int>(periodoInicio.millisecondsSinceEpoch),
      Variable<int>(periodoFim.millisecondsSinceEpoch),
    ]).getSingle();

    return row.data;
  }

  /// Lista todas as ordens de serviço para o autocomplete
  Future<List<Map<String, Object?>>> searchOrdensPorNumero(String numero) async {
    final result = await customSelect('''
      SELECT os.id, os.material, c.nome_empresa, os.valor_total
      FROM ordem_servico_table os
      LEFT JOIN clientes_table c ON c.id = os.cliente_id
      WHERE CAST(os.id AS TEXT) LIKE ? OR os.material LIKE ?
      ORDER BY os.id DESC
      LIMIT 10
    ''', variables: [
      Variable<String>('%$numero%'),
      Variable<String>('%$numero%'),
    ]).get();

    return result.map((r) => r.data).toList();
  }
}
