import 'package:drift/drift.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/fornecedor.dart';
import 'package:unilith_app/features/ordemServico/domain/vos/tamanho.dart';


import '../../../domain/entities/fornecedorOrdemServico.dart';
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
    // 1️⃣ Consulta principal: ordens + cliente + formato
    final ordensResult = await db.select(db.ordemServicoTable).join([
      leftOuterJoin(
        db.clientesTable,
        db.clientesTable.id.equalsExp(db.ordemServicoTable.clienteId),
      ),
      leftOuterJoin(
        db.formatoTable,
        db.formatoTable.id.equalsExp(db.ordemServicoTable.formatoId),
      ),
    ]).get();

    // 2️⃣ Busca fornecedores e custos de todas as ordens encontradas
    final ordemIds = ordensResult.map((row) => row.readTable(db.ordemServicoTable).id).toList();

    final fornecedoresResult = await (db.select(db.fornecedorOrdemServicoTable)
      ..where((tbl) => tbl.ordemServicoId.isIn(ordemIds))
    ).join([
      leftOuterJoin(
        db.fornecedorTable,
        db.fornecedorTable.id.equalsExp(db.fornecedorOrdemServicoTable.fornecedorId),
      ),
    ]).get();

    // 3️⃣ Agrupa fornecedores por ordemServicoId
    final fornecedoresPorOrdem = <int, List<FornecedorOrdemServico>>{};
    for (final row in fornecedoresResult) {

      final fornecedorOdemServico = row.readTable(db.fornecedorOrdemServicoTable);
      final fornecedoresResult = await (db.select(db.fornecedorTable)
        ..where((tbl) => tbl.id.equals(fornecedorOdemServico.fornecedorId))
      ).get();
      if(fornecedoresResult.isNotEmpty){

        final fornecedorData = fornecedoresResult.map((mp) => Fornecedor(
            id: mp.id,
            nome: mp.nome,
            tipoServico: mp.tipoServico,
            email: mp.email,
            telefone: mp.telefone,
            contato: mp.contato,
            observacao: mp.observacao
        )).single;


        fornecedoresPorOrdem.putIfAbsent(fornecedorOdemServico.ordemServicoId, () => []);
        fornecedoresPorOrdem[fornecedorOdemServico.ordemServicoId]!.add(
          FornecedorOrdemServico(
              fornecedor:  fornecedorData,
              custo: fornecedorOdemServico.custo)
          ,
        );
      }
    }

    // 4️⃣ Monta lista final de OrdemServico com fornecedores
    return ordensResult.map((row) {
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
        valorCusto: ordemData.valorCusto ?? 0.0,
        valorTotal: ordemData.valorTotal ?? 0.0,
        clientes: ClientesMapper.toEntity(clienteData),
        formato: FormatoMapper.toEntity(formatoData),
        fornecedores: fornecedoresPorOrdem[ordemData.id] ?? [],
        tamanhoImagem: new Tamanho(ordemData.tamanhoImagem)
      );
    }).toList();
  }


  @override
  Future<void> add(OrdemServico ordemServico) async {
    await db.transaction(() async {
      // 1️⃣ Insere a ordem de serviço e pega o ID
      final ordemId = await db.into(db.ordemServicoTable).insert(
        OrdemServicoMapper.toCompanion(ordemServico),
      );

      // 2️⃣ Insere fornecedores com custo (se houver)
      if (ordemServico.fornecedores!.isNotEmpty) {
        for (final fornecedorOrdemServico in ordemServico.fornecedores) {
          await db.into(db.fornecedorOrdemServicoTable).insert(
            FornecedorOrdemServicoTableCompanion.insert(
              ordemServicoId: ordemId,
              fornecedorId: fornecedorOrdemServico.fornecedor!.id,
              custo: Value(fornecedorOrdemServico.custo),
            ),
          );
        }
      }
    });
  }




  @override
  Future<void> update(OrdemServico ordemServico) async {
    await db.transaction(() async {
      // 1️⃣ Atualiza a ordem de serviço
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
          tamanhoImagem: Value(ordemServico.tamanhoImagem.toString())
        ),
      );

      // 2️⃣ Remove fornecedores antigos dessa ordem
      await (db.delete(db.fornecedorOrdemServicoTable)
        ..where((tbl) => tbl.ordemServicoId.equals(ordemServico.id))
      ).go();

      // 3️⃣ Insere fornecedores novos
      if (ordemServico.fornecedores.isNotEmpty) {
        for (final fornecedorOrdem in ordemServico.fornecedores) {
          await db.into(db.fornecedorOrdemServicoTable).insert(
            FornecedorOrdemServicoTableCompanion.insert(
              ordemServicoId: ordemServico.id,
              fornecedorId: fornecedorOrdem.fornecedor!.id,
              custo: Value(fornecedorOrdem.custo),
            ),
          );
        }
      }
    });
  }


  @override
  Future<void> delete(int id) async {
    await (db.delete(db.ordemServicoTable)..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
