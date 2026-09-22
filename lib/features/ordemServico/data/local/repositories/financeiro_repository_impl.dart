import 'package:drift/drift.dart';
import 'package:unilith_app/features/ordemServico/data/local/app_database.dart';
import 'finance_dao.dart';
import '../../../domain/fatura_resumo_dto.dart';
import '../../../domain/ordem_servico_financeiro_resumo_dto.dart';
import '../../../domain/parcela_dto.dart';
import '../../../domain/parcela_resumo_dto.dart';
import '../../../domain/relatorio_mensal_dto.dart';
import '../../../domain/repositories/financeiro_repository.dart';
import '../../../presentation/core/parcel_calculator.dart';

class FinanceiroRepositoryImpl implements FinanceiroRepository {
  final FinanceDao dao;

  FinanceiroRepositoryImpl(this.dao);

  @override
  Future<int> criarFatura(
      {int? ordemServicoId, String? descricao, required double valorTotal}) async {
    final companion = FaturaTableCompanion.insert(
      ordemServicoId: Value(ordemServicoId),
      descricao: Value(descricao),
      valorTotal: Value(valorTotal),
      // createdAt is required; use now
      createdAt: DateTime.now(),
    );

    return await dao.into(dao.faturaTable).insert(companion);
  }

  @override
  Future<List<FaturaResumoDto>> obterFaturasComTotais() async {
    final rows = await dao.faturasComTotais();
    return rows.map((r) => FaturaResumoDto.fromMap(r)).toList();
  }

  @override
  Future<List<ParcelaDto>> obterParcelasVencidas(DateTime agora) async {
    final list = await dao.parcelasVencidas(agora);
    return list.map((p) =>
        ParcelaDto(
          id: p.id,
          faturaId: p.faturaId,
          numero: p.numero,
          valor: p.valor,
          dataEmissao: p.dataEmissao,
          vencimento: p.vencimento,
          status: p.status,
        )).toList();
  }

  @override
  Future<List<ParcelaResumoDto>> obterParcelasPorFatura(int faturaId) async {
    final rows = await dao.parcelasComTotaisPorFatura(faturaId);
    return rows.map((r) => ParcelaResumoDto.fromMap(r)).toList();
  }

  @override
  Future<int> registrarRecebimento(
      {required int parcelaId, required double valor, required DateTime dataPagamento, String? formaPagamento}) async {
    // Inserir recebimento
    final recebimento = RecebimentoTableCompanion.insert(
      parcelaId: parcelaId,
      valor: Value(valor),
      dataPagamento: dataPagamento,
      formaPagamento: Value(formaPagamento),
    );

    final id = await dao.into(dao.recebimentoTable).insert(recebimento);

    // Recalcular soma de recebimentos para a parcela e atualizar status se necessário
    final totalRow = await dao.customSelect('''
      SELECT IFNULL(SUM(valor), 0) AS total
      FROM recebimento_table
      WHERE parcela_id = ?
    ''', variables: [Variable<int>(parcelaId)]).getSingle();

    final total = (totalRow.data['total'] as num).toDouble();

    final parcela = await (dao.select(dao.parcelaTable)
      ..where((t) => t.id.equals(parcelaId))).getSingle();

    // Tolerância de meio centavo para absorver ruído de ponto flutuante
    // (ex.: 1000/3 = 333.3333...) e evitar que a parcela fique "quase paga"
    // sem nunca atingir o status PAGA.
    if (total >= parcela.valor - 0.005) {
      await (dao.update(dao.parcelaTable)
        ..where((t) => t.id.equals(parcelaId))).write(
          ParcelaTableCompanion(status: const Value('PAGA')));
    }

    await _atualizarStatusFatura(parcela.faturaId);

    return id;
  }

  /// Recalcula o status da fatura (ABERTA / PARCIAL / PAGA) a partir da
  /// soma de todos os recebimentos das suas parcelas.
  Future<void> _atualizarStatusFatura(int faturaId) async {
    final totalRow = await dao.customSelect('''
      SELECT IFNULL(SUM(r.valor), 0) AS total
      FROM recebimento_table r
      JOIN parcela_table p ON p.id = r.parcela_id
      WHERE p.fatura_id = ?
    ''', variables: [Variable<int>(faturaId)]).getSingle();

    final totalRecebidoFatura = (totalRow.data['total'] as num).toDouble();

    final fatura = await (dao.select(dao.faturaTable)
      ..where((t) => t.id.equals(faturaId))).getSingle();

    final String status;
    if (totalRecebidoFatura <= 0) {
      status = 'ABERTA';
    } else if (totalRecebidoFatura >= fatura.valorTotal - 0.005) {
      status = 'PAGA';
    } else {
      status = 'PARCIAL';
    }

    await (dao.update(dao.faturaTable)
      ..where((t) => t.id.equals(faturaId)))
        .write(FaturaTableCompanion(status: Value(status)));
  }

  @override
  Future<double> totalRecebidoNoMes(int year, int month) async {
    final start = DateTime(year, month, 1).millisecondsSinceEpoch;
    final end = DateTime(year, month + 1, 1).millisecondsSinceEpoch;

    final row = await dao.customSelect('''
      SELECT IFNULL(SUM(valor), 0) AS total
      FROM recebimento_table
      WHERE data_pagamento >= ? AND data_pagamento < ?
    ''', variables: [Variable<int>(start), Variable<int>(end)]).getSingle();

    return ((row.data['total'] ?? 0) as num).toDouble();
  }

  @override
  Future<double> totalDespesasNoMes(int year, int month) async {
    final start = DateTime(year, month, 1).millisecondsSinceEpoch;
    final end = DateTime(year, month + 1, 1).millisecondsSinceEpoch;

    final row = await dao.customSelect('''
      SELECT IFNULL(SUM(valor), 0) AS total
      FROM despesa_table
      WHERE data >= ? AND data < ?
    ''', variables: [Variable<int>(start), Variable<int>(end)]).getSingle();

    return ((row.data['total'] ?? 0) as num).toDouble();
  }

  @override
  Future<int> criarFaturaComParcelas({
    required int? ordemServicoId,
    required String? descricao,
    required double valorTotal,
    required DateTime dataEmissao,
    required DateTime dataVencimento,
    required int quantidadeParcelas,
  }) async {
    if (quantidadeParcelas < 1 || quantidadeParcelas > kMaxParcelasFatura) {
      throw ArgumentError(
          'Quantidade de parcelas deve ser entre 1 e $kMaxParcelasFatura');
    }

    // Cria a fatura
    final faturaCompanion = FaturaTableCompanion.insert(
      ordemServicoId: Value(ordemServicoId),
      descricao: Value(descricao),
      valorTotal: Value(valorTotal),
      createdAt: dataEmissao,
    );

    // Reaproveita o mesmo cálculo usado no preview exibido ao usuário,
    // para que o que foi mostrado seja exatamente o que é persistido.
    final parcelas = ParcelCalculator.generateParcelas(
      quantidadeParcelas: quantidadeParcelas,
      valorTotal: valorTotal,
      dataEmissao: dataEmissao,
      dataVencimentoInicial: dataVencimento,
      incrementoMeses: 0,
    );

    // Transação: se a criação de qualquer parcela falhar, a fatura não
    // fica órfã sem parcelas — tudo é desfeito junto.
    return dao.transaction(() async {
      final faturaId = await dao.into(dao.faturaTable).insert(faturaCompanion);

      for (final parcela in parcelas) {
        final parcelaCompanion = ParcelaTableCompanion.insert(
          faturaId: faturaId,
          numero: Value(parcela.numero),
          valor: Value(parcela.valor),
          dataEmissao: Value(parcela.dataEmissao),
          vencimento: parcela.vencimento,
          status: const Value('ABERTA'),
        );

        await dao.into(dao.parcelaTable).insert(parcelaCompanion);
      }

      return faturaId;
    });
  }

  @override
  Future<List<int>> criarMultiplasFaturasParaOS({
    required int ordemServicoId,
    required int quantidadeFaturas,
    required double valorUnitario,
    required DateTime dataEmissao,
    String? descricao,
  }) async {
    return dao.transaction(() async {
      final faturaIds = <int>[];

      for (int i = 0; i < quantidadeFaturas; i++) {
        // Cria fatura
        final faturaCompanion = FaturaTableCompanion.insert(
          ordemServicoId: Value(ordemServicoId),
          descricao: Value(descricao),
          valorTotal: Value(valorUnitario),
          createdAt: dataEmissao.add(Duration(days: i)),
        );

        final faturaId =
            await dao.into(dao.faturaTable).insert(faturaCompanion);
        faturaIds.add(faturaId);

        // Cria uma parcela para cada fatura
        final parcelaCompanion = ParcelaTableCompanion.insert(
          faturaId: faturaId,
          numero: const Value(1),
          valor: Value(valorUnitario),
          dataEmissao: Value(dataEmissao.add(Duration(days: i))),
          vencimento: dataEmissao.add(Duration(days: i)),
          status: const Value('ABERTA'),
        );

        await dao.into(dao.parcelaTable).insert(parcelaCompanion);
      }

      return faturaIds;
    });
  }

  @override
  Future<void> vincularFaturaAOS({
    required int faturaId,
    required int ordemServicoId,
  }) async {
    await (dao.update(dao.faturaTable)
      ..where((t) => t.id.equals(faturaId)))
        .write(FaturaTableCompanion(ordemServicoId: Value(ordemServicoId)));
  }

  @override
  Future<void> deletarFatura(int faturaId) async {
    await dao.transaction(() async {
      final parcelaIds = await (dao.select(dao.parcelaTable)
            ..where((t) => t.faturaId.equals(faturaId)))
          .map((p) => p.id)
          .get();

      if (parcelaIds.isNotEmpty) {
        await (dao.delete(dao.recebimentoTable)
              ..where((t) => t.parcelaId.isIn(parcelaIds)))
            .go();
      }

      await (dao.delete(dao.parcelaTable)
            ..where((t) => t.faturaId.equals(faturaId)))
          .go();

      await (dao.delete(dao.faturaTable)..where((t) => t.id.equals(faturaId)))
          .go();
    });
  }

  @override
  Future<RelatorioMensalDto> resultadoMensal(int year, int month) async {
    final totalRecebido = await totalRecebidoNoMes(year, month);
    final totalDespesas = await totalDespesasNoMes(year, month);

    return RelatorioMensalDto(
      year: year,
      month: month,
      totalRecebido: totalRecebido,
      totalDespesas: totalDespesas,
      resultado: totalRecebido - totalDespesas,
    );
  }

  @override
  Future<List<OrdemServicoFinanceiroResumoDto>> obterResumoFinanceiroPorOrdemServico({
    required DateTime periodoInicio,
    required DateTime periodoFim,
    int? ordemServicoId,
    int? faturaId,
  }) async {
    final rows = await dao.resumoFinanceiroPorOrdemServico(
      periodoInicio: periodoInicio,
      periodoFim: periodoFim,
      ordemServicoId: ordemServicoId,
      faturaId: faturaId,
    );
    return rows.map((r) => OrdemServicoFinanceiroResumoDto.fromMap(r)).toList();
  }

  @override
  Future<({double faturado, double recebido, int quantidade})> obterFaturamentoSemOrdemServico({
    required DateTime periodoInicio,
    required DateTime periodoFim,
  }) async {
    final row = await dao.faturamentoSemOrdemServico(
      periodoInicio: periodoInicio,
      periodoFim: periodoFim,
    );
    return (
      faturado: (row['faturado'] as num?)?.toDouble() ?? 0.0,
      recebido: (row['recebido'] as num?)?.toDouble() ?? 0.0,
      quantidade: (row['quantidade'] as num?)?.toInt() ?? 0,
    );
  }
}