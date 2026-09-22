import '../../domain/parcela_dto.dart';

/// Classe responsável por calcular parcelas baseado em diferentes modos
class ParcelCalculator {
  /// Calcula parcelas pelo modo Por Data
  /// Retorna lista de parcelas com datas calculadas
  static List<ParcelaPreview> calculateByDate({
    required DateTime dataEmissao,
    required DateTime dataVencimento,
    required double valorTotal,
  }) {
    // Calcula diferença em meses
    final meses = _calculateMonthsDifference(dataEmissao, dataVencimento);
    final quantidadeParcelas = meses > 0 ? meses : 1;

    return generateParcelas(
      quantidadeParcelas: quantidadeParcelas,
      valorTotal: valorTotal,
      dataEmissao: dataEmissao,
      dataVencimentoInicial: dataVencimento,
      incrementoMeses: 0, // Não incrementa, usa datas fixas
    );
  }

  /// Calcula parcelas pelo modo Por Parcelas
  /// Retorna lista de parcelas com datas incrementadas mensalmente
  static List<ParcelaPreview> calculateByInstallments({
    required int quantidadeParcelas,
    required DateTime dataPrimeiraParcela,
    required double valorTotal,
  }) {
    return generateParcelas(
      quantidadeParcelas: quantidadeParcelas,
      valorTotal: valorTotal,
      dataEmissao: dataPrimeiraParcela,
      dataVencimentoInicial: dataPrimeiraParcela,
      incrementoMeses: 1, // Incrementa 1 mês a cada parcela
    );
  }

  /// Gera lista de parcelas com cálculos automáticos.
  /// Público para que a camada de persistência reutilize exatamente o
  /// mesmo cronograma exibido no preview, evitando divergência entre
  /// o que é mostrado e o que é gravado.
  static List<ParcelaPreview> generateParcelas({
    required int quantidadeParcelas,
    required double valorTotal,
    required DateTime dataEmissao,
    required DateTime dataVencimentoInicial,
    required int incrementoMeses,
  }) {
    final parcelas = <ParcelaPreview>[];

    // Os valores são arredondados em centavos e a última parcela absorve o
    // resíduo do arredondamento, garantindo que a soma das parcelas seja
    // sempre exatamente igual ao valor total (evita divergências de ponto
    // flutuante como 1000/3 = 333.3333... que nunca "fecham" o pagamento).
    final valorTotalCentavos = (valorTotal * 100).round();
    final valorParcelaCentavos = valorTotalCentavos ~/ quantidadeParcelas;
    final residuoCentavos =
        valorTotalCentavos - (valorParcelaCentavos * quantidadeParcelas);

    for (int i = 0; i < quantidadeParcelas; i++) {
      final dataEmissaoParcela =
          incrementoMeses > 0
              ? dataEmissao.add(Duration(days: 30 * i * incrementoMeses))
              : dataEmissao.add(Duration(days: 30 * i));

      final dataVencimentoParcela =
          incrementoMeses > 0
              ? dataVencimentoInicial.add(Duration(days: 30 * i * incrementoMeses))
              : dataVencimentoInicial.add(Duration(days: 30 * i));

      final ehUltima = i == quantidadeParcelas - 1;
      final valorCentavos =
          valorParcelaCentavos + (ehUltima ? residuoCentavos : 0);

      parcelas.add(
        ParcelaPreview(
          numero: i + 1,
          valor: valorCentavos / 100,
          dataEmissao: dataEmissaoParcela,
          vencimento: dataVencimentoParcela,
        ),
      );
    }

    return parcelas;
  }

  /// Calcula diferença em meses entre duas datas
  static int _calculateMonthsDifference(DateTime start, DateTime end) {
    if (end.isBefore(start)) return 0;

    int meses = 0;
    DateTime current = start;

    while (!current.isAfter(end)) {
      current = _addMonthClamped(current);
      if (!current.isAfter(end)) {
        meses++;
      }
    }

    return meses;
  }

  /// Soma um mês a [date], ajustando o dia para o último dia do mês de
  /// destino quando ele não existir (ex.: 31/jan -> 28 ou 29/fev, nunca 03/mar).
  static DateTime _addMonthClamped(DateTime date) {
    final year = date.year + (date.month == 12 ? 1 : 0);
    final month = date.month == 12 ? 1 : date.month + 1;
    final lastDayOfMonth = DateTime(year, month + 1, 0).day;
    final day = date.day > lastDayOfMonth ? lastDayOfMonth : date.day;
    return DateTime(year, month, day);
  }
}

/// Classe auxiliar para exibir preview de parcelas
class ParcelaPreview {
  final int numero;
  final double valor;
  final DateTime dataEmissao;
  final DateTime vencimento;

  ParcelaPreview({
    required this.numero,
    required this.valor,
    required this.dataEmissao,
    required this.vencimento,
  });

  @override
  String toString() => 'Parcela #$numero - R\$ ${valor.toStringAsFixed(2)} - Venc: ${_formatDate(vencimento)}';

  static String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';
}
