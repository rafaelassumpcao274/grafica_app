import 'package:drift/drift.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/fornecedor.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/viaCoresOrdemServico.dart';
import 'package:unilith_app/features/ordemServico/domain/vos/tamanho.dart';

import '../../../domain/entities/fornecedorOrdemServico.dart';
import '../../../domain/entities/ordemservico.dart';
import '../../../domain/entities/via_cores.dart';
import '../../../domain/repositories/ordemservico_repository.dart';
import '../app_database.dart';
import '../mappers/clientes_mapper.dart' show ClientesMapper;
import '../mappers/formato_mapper.dart' show FormatoMapper;
import '../mappers/ordemservico_mapper.dart' show OrdemServicoMapper;
import '../mappers/papel_mapper.dart' show PapelMapper;


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
      leftOuterJoin(
        db.papelTable,
        db.papelTable.id.equalsExp(db.ordemServicoTable.papelId),
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

    final viasResult = await (db.select(db.viaCoresOrdemServicoTable)
      ..where((tbl) => tbl.ordemServicoId.isIn(ordemIds))
    ).join([
      leftOuterJoin(
        db.viaCoresTable,
        db.viaCoresTable.id.equalsExp(db.viaCoresOrdemServicoTable.viaCoresId),
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

    final viasPorOrdem = <int, List<ViaCoresOrdemServico>>{};
    for (final row in viasResult) {

      final viasOdemServico = row.readTable(db.viaCoresOrdemServicoTable);
      final viaResult = await (db.select(db.viaCoresTable)
        ..where((tbl) => tbl.id.equals(viasOdemServico.viaCoresId))
      ).get();
      if(viaResult.isNotEmpty){

        final viaData = viaResult.map((mp) => ViaCores(
            id: mp.id,
          descricao: mp.descricao
        )).single;


        viasPorOrdem.putIfAbsent(viasOdemServico.ordemServicoId, () => []);
        viasPorOrdem[viasOdemServico.ordemServicoId]!.add(
          ViaCoresOrdemServico(
              viaCores:  viaData,
              ordem: viasOdemServico.ordem)
          ,
        );
      }
    }

    // 4️⃣ Monta lista final de OrdemServico com fornecedores
    return ordensResult.map((row) {
      final ordemData = row.readTable(db.ordemServicoTable);
      final clienteData = row.readTableOrNull(db.clientesTable);
      final formatoData = row.readTableOrNull(db.formatoTable);
      final papelData = row.readTableOrNull(db.papelTable);

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
        papel: PapelMapper.toEntity(papelData),
        fornecedores: fornecedoresPorOrdem[ordemData.id] ?? [],
        vias: viasPorOrdem[ordemData.id] ?? [],
        tamanhoImagem: ordemData.tamanhoImagem.isNotEmpty ? new Tamanho(ordemData.tamanhoImagem): null,
          createdAt: ordemData.createdAt
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
      if (ordemServico.vias!.isNotEmpty) {
        for (final viasOrdemServico in ordemServico.vias) {
          await db.into(db.viaCoresOrdemServicoTable).insert(
            ViaCoresOrdemServicoTableCompanion.insert(
              ordemServicoId: ordemId,
              viaCoresId: viasOrdemServico.viaCores!.id,
              ordem: Value(viasOrdemServico.ordem),
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
          papelId: Value(ordemServico.papel?.id ?? ''),
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
          tamanhoImagem: Value(ordemServico.tamanhoImagem != null ? ordemServico.tamanhoImagem.toString(): '')
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



      // 3️⃣ Insere fornecedores novos
      if (ordemServico.vias.isNotEmpty) {
        await (db.delete(db.viaCoresOrdemServicoTable)
          ..where((tbl) => tbl.ordemServicoId.equals(ordemServico.id))
        ).go();

        for (final viaCoresOrdem in ordemServico.vias) {
          await db.into(db.viaCoresOrdemServicoTable).insert(
            ViaCoresOrdemServicoTableCompanion.insert(
              ordemServicoId: ordemServico.id,
              viaCoresId: viaCoresOrdem.viaCores!.id,
              ordem: Value(viaCoresOrdem.ordem),
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
