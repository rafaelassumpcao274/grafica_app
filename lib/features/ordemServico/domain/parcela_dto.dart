class ParcelaDto {
  final int id;
  final int faturaId;
  final int numero;
  final double valor;
  final DateTime dataEmissao;
  final DateTime vencimento;
  final String status;

  ParcelaDto({
    required this.id,
    required this.faturaId,
    required this.numero,
    required this.valor,
    required this.dataEmissao,
    required this.vencimento,
    required this.status,
  });

  factory ParcelaDto.fromData(Map<String, Object?> m) {
    return ParcelaDto(
      id: (m['id'] as num).toInt(),
      faturaId: (m['fatura_id'] as num).toInt(),
      numero: (m['numero'] as num).toInt(),
      valor: (m['valor'] as num).toDouble(),
      dataEmissao: m['data_emissao'] != null
          ? DateTime.fromMillisecondsSinceEpoch((m['data_emissao'] as num).toInt())
          : DateTime.now(),
      vencimento: DateTime.fromMillisecondsSinceEpoch((m['vencimento'] as num).toInt()),
      status: (m['status'] as String?) ?? 'ABERTA',
    );
  }
}
