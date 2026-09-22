class FaturaResumoDto {
  final int id;
  final int? ordemServicoId;
  final String? descricao;
  final double valorTotal;
  final double totalRecebido;
  final double saldo;
  final String status;
  final DateTime createdAt;
  final String? clienteNome;
  final String? osNumeroMaterial;

  FaturaResumoDto({
    required this.id,
    this.ordemServicoId,
    this.descricao,
    required this.valorTotal,
    required this.totalRecebido,
    required this.saldo,
    required this.status,
    required this.createdAt,
    this.clienteNome,
    this.osNumeroMaterial,
  });

  factory FaturaResumoDto.fromMap(Map<String, Object?> m) {
    return FaturaResumoDto(
      id: (m['id'] as num).toInt(),
      ordemServicoId: m['ordem_servico_id'] as int?,
      descricao: m['descricao'] as String?,
      valorTotal: (m['valor_total'] as num?)?.toDouble() ?? 0.0,
      totalRecebido: (m['total_recebido'] as num?)?.toDouble() ?? 0.0,
      saldo: (m['saldo'] as num?)?.toDouble() ?? 0.0,
      status: (m['status'] as String?) ?? 'ABERTA',
      createdAt: m['created_at'] != null 
        ? DateTime.fromMillisecondsSinceEpoch((m['created_at'] as num).toInt())
        : DateTime.now(),
      clienteNome: m['cliente_nome'] as String?,
      osNumeroMaterial: m['os_numero_material'] as String?,
    );
  }
}
