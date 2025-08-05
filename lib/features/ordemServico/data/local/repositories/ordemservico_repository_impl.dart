import 'package:drift/drift.dart';


import '../../../domain/entities/ordemservico.dart';
import '../../../domain/repositories/ordemservico_repository.dart';
import '../app_database.dart';
import '../mappers/ordemservico_mapper.dart' show OrdemServicoMapper;
import '../mappers/formato_mapper.dart' show FormatoMapper;
import '../mappers/clientes_mapper.dart' show ClientesMapper;


class OrdemServicoRepositoryImpl implements OrdemServicoRepository {
  final AppDatabase db;
  OrdemServicoRepositoryImpl(this.db);

  @override
  Future<List<OrdemServico>> getOrdensServico() async {
    final result = await db.select(db.ordemServicoTable).join([
      leftOuterJoin(
        db.clientesTable,
        db.clientesTable.id.equalsExp(db.ordemServicoTable.clienteId),
      ),
      leftOuterJoin(
        db.formatoTable,
        db.formatoTable.id.equalsExp(db.ordemServicoTable.formatoId),
      ),
    ]).get();

    return result.map((row) {
      final ordemData = row.readTable(db.ordemServicoTable);
      final clienteData = row.readTableOrNull(db.clientesTable);
      final formatoData = row.readTableOrNull(db.formatoTable);

      return OrdemServico(
        id: ordemData.id,
        material: ordemData.material,
        corFrente: ordemData.corFrente,
        corVerso: ordemData.corVerso,
        quantidadeFolha: ordemData.quantidadeFolha,
        possuiNumeracao: ordemData.possuiNumeracao,
        numeracaoInicial: ordemData.numeracaoInicial,
        numeracaoFinal: ordemData.numeracaoFinal,
        observacao: ordemData.observacao,
        valorCusto: ordemData.valorCusto  ?? 0.0,
        valorTotal: ordemData.valorTotal ?? 0.0,
        clientes: ClientesMapper.toEntity(clienteData),
        formato: FormatoMapper.toEntity(formatoData),
      );
    }).toList();
  }

  @override
  Future<void> add(OrdemServico ordemServico) async {
    await db.into(db.ordemServicoTable).insert(
          OrdemServicoMapper.toCompanion(ordemServico),
        );
  }



  @override
  Future<void> update(OrdemServico ordemServico) async {
    await db.update(db.ordemServicoTable).replace(
          OrdemServicoTableCompanion(
            id: Value(ordemServico.id),
            clienteId: Value(ordemServico.clientes?.id ?? ''),
            formatoId: Value(ordemServico.formato?.id ?? ''),
            material: Value(ordemServico.material),
            corFrente: Value(ordemServico.corFrente),
            corVerso: Value(ordemServico.corVerso),
            quantidadeFolha: Value(ordemServico.quantidadeFolha),
            possuiNumeracao: Value(ordemServico.possuiNumeracao),
            numeracaoInicial: Value(ordemServico.numeracaoInicial),
            numeracaoFinal: Value(ordemServico.numeracaoFinal),
            valorCusto: Value(ordemServico.valorCusto),
            valorTotal: Value(ordemServico.valorTotal),
            observacao: Value(ordemServico.observacao),
          ),
        );
  }

  @override
  Future<void> delete(int id) async {
    await (db.delete(db.ordemServicoTable)..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
