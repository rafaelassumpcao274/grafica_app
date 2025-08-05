
// Ensure OrdemServicoTableData is imported from its definition

import 'package:drift/drift.dart';

import '../../../domain/entities/ordemservico.dart';
import '../app_database.dart';

class OrdemServicoMapper{

  static OrdemServico toEntity(OrdemServicoTableData data) {
    return OrdemServico(
      id: data.id,
      material: data.material,
      corFrente: data.corFrente,
      corVerso: data.corVerso,
      quantidadeFolha: data.quantidadeFolha,
      possuiNumeracao: data.possuiNumeracao,
      numeracaoInicial: data.numeracaoInicial,
      numeracaoFinal: data.numeracaoFinal,
      valorCusto: data.valorCusto,
      valorTotal: data.valorTotal,
      observacao: data.observacao,
    );
  }

  static OrdemServicoTableCompanion toCompanion(OrdemServico entity) {
    return OrdemServicoTableCompanion(
      id: entity.id == 0 ? Value.absent() : Value(entity.id),
      clienteId: Value(entity.clientes?.id ?? ''),
      formatoId: Value(entity.formato?.id ?? ''),
      material: Value(entity.material),
      corFrente: Value(entity.corFrente),
      corVerso: Value(entity.corVerso),
      quantidadeFolha: Value(entity.quantidadeFolha),
      possuiNumeracao: Value(entity.possuiNumeracao),
      numeracaoInicial: Value(entity.numeracaoInicial),
      numeracaoFinal: Value(entity.numeracaoFinal),
      observacao: Value(entity.observacao),
      valorCusto: Value(entity.valorCusto),
      valorTotal: Value(entity.valorTotal),
    );
  }

}