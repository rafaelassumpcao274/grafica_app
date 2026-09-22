class RelatorioMensalDto {
  final int year;
  final int month;
  final double totalRecebido;
  final double totalDespesas;
  final double resultado;

  RelatorioMensalDto({
    required this.year,
    required this.month,
    required this.totalRecebido,
    required this.totalDespesas,
    required this.resultado,
  });
}
