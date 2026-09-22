class OrdemServicoFinanceiroResumoDto {
  final int ordemServicoId;
  final String material;
  final String? clienteNome;
  final DateTime? ordemServicoCreatedAt;
  final double contratado;
  final double faturado;
  final double recebido;
  final int quantidadeFaturas;

  double get saldo => faturado - recebido;
  double get faltaFaturar => contratado - faturado;

  OrdemServicoFinanceiroResumoDto({
    required this.ordemServicoId,
    required this.material,
    this.clienteNome,
    this.ordemServicoCreatedAt,
    required this.contratado,
    required this.faturado,
    required this.recebido,
    required this.quantidadeFaturas,
  });

  factory OrdemServicoFinanceiroResumoDto.fromMap(Map<String, Object?> m) {
    return OrdemServicoFinanceiroResumoDto(
      ordemServicoId: (m['ordem_servico_id'] as num).toInt(),
      material: (m['material'] as String?) ?? '',
      clienteNome: m['cliente_nome'] as String?,
      // os_created_at vem em epoch SEGUNDOS (DateTimeColumn nativo do drift),
      // diferente de fatura/parcela/recebimento que usam epoch em milissegundos.
      ordemServicoCreatedAt: m['os_created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (m['os_created_at'] as num).toInt() * 1000)
          : null,
      contratado: (m['contratado'] as num?)?.toDouble() ?? 0.0,
      faturado: (m['faturado'] as num?)?.toDouble() ?? 0.0,
      recebido: (m['recebido'] as num?)?.toDouble() ?? 0.0,
      quantidadeFaturas: (m['quantidade_faturas'] as num?)?.toInt() ?? 0,
    );
  }
}
