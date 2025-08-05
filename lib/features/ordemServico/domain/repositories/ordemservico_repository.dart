import '../entities/ordemservico.dart';

abstract class OrdemServicoRepository {
  Future<List<OrdemServico>> getOrdensServico();
  Future<void> add(OrdemServico ordemServico);
  Future<void> update(OrdemServico ordemServico);
  Future<void> delete(int id);
}
