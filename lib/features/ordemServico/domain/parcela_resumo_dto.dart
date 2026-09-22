class ParcelaResumoDto {
  final int id;
  final int faturaId;
  final int numero;
  final double valor;
  final double totalRecebido;
  final double saldo;
  final DateTime vencimento;
  final String status;

  ParcelaResumoDto({
    required this.id,
    required this.faturaId,
    required this.numero,
    required this.valor,
    required this.totalRecebido,
    required this.saldo,
    required this.vencimento,
    required this.status,
  });

  factory ParcelaResumoDto.fromMap(Map<String, Object?> m) {
    return ParcelaResumoDto(
      id: (m['id'] as num).toInt(),
      faturaId: (m['fatura_id'] as num).toInt(),
      numero: (m['numero'] as num).toInt(),
      valor: (m['valor'] as num).toDouble(),
      totalRecebido: (m['total_recebido'] as num?)?.toDouble() ?? 0.0,
      saldo: (m['saldo'] as num?)?.toDouble() ?? 0.0,
      vencimento:
          DateTime.fromMillisecondsSinceEpoch((m['vencimento'] as num).toInt()),
      status: (m['status'] as String?) ?? 'ABERTA',
    );
  }
}
