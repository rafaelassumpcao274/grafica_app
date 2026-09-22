import 'dart:io';


import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'package:unilith_app/features/ordemServico/data/local/seed/formato_seed.dart';
import 'package:unilith_app/features/ordemServico/data/local/seed/papel_seed.dart';
import 'package:unilith_app/features/ordemServico/data/local/seed/viacores_seed.dart';
import 'package:unilith_app/features/ordemServico/data/local/tables/fornecedor_ordem_servico.dart';
import 'package:unilith_app/features/ordemServico/data/local/tables/vias_ordem_servico.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/enums/TipoServico.dart';
import 'config/sqlite_date_time_converter.dart';
import 'config/sqlite_epoch_ms_date_time_converter.dart';
import 'config/sqlite_tipo_servico_converter.dart';
import 'migration/master.dart';
import 'tables/fornecedor_table.dart';
import 'tables/formato_table.dart';
import 'tables/viacores_table.dart';
import 'tables/papel_table.dart';
import 'tables/uf_table.dart';
import 'tables/clientes_table.dart';
import 'tables/ordemservico_table.dart';
import 'tables/fatura_table.dart';
import 'tables/parcela_table.dart';
import 'tables/recebimento_table.dart';
import 'tables/despesa_table.dart';
import 'tables/forma_pagamento_table.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(
      file,
      setup: (rawDb) {
        rawDb.execute('PRAGMA journal_mode=WAL;');
        rawDb.execute('PRAGMA synchronous=NORMAL;');
      },
    );
  });
}

@DriftDatabase(tables: [
  FornecedorTable,
  FormatoTable,
  ViaCoresTable,
  PapelTable,
  UfTable,
  ClientesTable,
  OrdemServicoTable,
  FornecedorOrdemServicoTable,
  ViaCoresOrdemServicoTable,
  // Financeiro
  FaturaTable,
  ParcelaTable,
  RecebimentoTable,
  DespesaTable,
  FormaPagamentoTable
])
class AppDatabase extends _$AppDatabase {
  // ignore: use_super_parameters
  AppDatabase._internal(QueryExecutor e) : super(e);

  static AppDatabase? _instance;

  /// Cria (ou retorna) a instância única
  static Future<AppDatabase> getInstance() async {
    if (_instance != null) return _instance!;

    final executor = _openConnection();
    final db = AppDatabase._internal(executor);

    /// Insere seeds apenas se necessário

    _instance = db;
    return _instance!;
  }

  @override
  int get schemaVersion =>
      5; // v5: adiciona índices de performance nas colunas de FK

  /// Índices nas colunas de FK usadas nos JOINs/WHEREs de
  /// ordemservico_repository_impl.dart e finance_dao.dart. SQLite não
  /// indexa FKs automaticamente. SQL puro (sem @TableIndex) para não
  /// depender de regenerar o código gerado pelo drift.
  Future<void> _createPerformanceIndexes() async {
    const statements = [
      'CREATE INDEX IF NOT EXISTS idx_ordem_servico_cliente_id ON ordem_servico_table(cliente_id);',
      'CREATE INDEX IF NOT EXISTS idx_ordem_servico_formato_id ON ordem_servico_table(formato_id);',
      'CREATE INDEX IF NOT EXISTS idx_ordem_servico_papel_id ON ordem_servico_table(papel_id);',
      'CREATE INDEX IF NOT EXISTS idx_fornecedor_ordem_servico_ordem_id ON fornecedor_ordem_servico_table(ordem_servico_id);',
      'CREATE INDEX IF NOT EXISTS idx_fornecedor_ordem_servico_fornecedor_id ON fornecedor_ordem_servico_table(fornecedor_id);',
      'CREATE INDEX IF NOT EXISTS idx_via_cores_ordem_servico_ordem_id ON via_cores_ordem_servico_table(ordem_servico_id);',
      'CREATE INDEX IF NOT EXISTS idx_via_cores_ordem_servico_via_id ON via_cores_ordem_servico_table(via_cores_id);',
      'CREATE INDEX IF NOT EXISTS idx_fatura_ordem_servico_id ON fatura_table(ordem_servico_id);',
      'CREATE INDEX IF NOT EXISTS idx_parcela_fatura_id ON parcela_table(fatura_id);',
      'CREATE INDEX IF NOT EXISTS idx_recebimento_parcela_id ON recebimento_table(parcela_id);',
    ];
    for (final stmt in statements) {
      await customStatement(stmt);
    }
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll(); // cria todas as tabelas automaticamente
      await _createPerformanceIndexes();

      // Insere seeds apenas na criação
      await insertSeedData(this);
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Exemplo: migrações automáticas
      if (from < 2) {
        // await m.addColumn(papelTable, papelTable.novaColuna);
        // await m.createTable(novaTabelaTable);
      }

      if (from < 3) {
        // 1️⃣ Normaliza valores inválidos (defensivo)
        await customStatement('''
              UPDATE ordem_servico_table
              SET created_at = datetime('now')
              WHERE created_at IS NULL
                 OR created_at = ''
                 OR created_at = 'CURRENT_TIMESTAMP';
            ''');

        // 2️⃣ Recria a tabela para alinhar o tipo DateTime
        await m.alterTable(
          TableMigration(
            ordemServicoTable,
            newColumns: [ordemServicoTable.createdAt],
          ),
        );

        // 3️⃣ Cria tabelas do módulo financeiro
        await m.createTable(faturaTable);
        await m.createTable(parcelaTable);
        await m.createTable(recebimentoTable);
        await m.createTable(despesaTable);
        await m.createTable(formaPagamentoTable);
      }

      if (from < 4) {
        // parcela_table.dataEmissao foi adicionada após a criação inicial
        // das tabelas financeiras (quem já estava na v3 não tem a coluna).
        await m.addColumn(parcelaTable, parcelaTable.dataEmissao);
      }

      if (from < 5) {
        await _createPerformanceIndexes();
      }
    },
  );

  static Future<void> insertSeedData(AppDatabase db) async {
    for (final formato in formatoSeed) {
      await db.into(db.formatoTable).insert(formato);
    }
    for (final papel in papelSeed) {
      await db.into(db.papelTable).insert(papel);
    }
    for (final cores in viacoresSeed) {
      await db.into(db.viaCoresTable).insert(cores);
    }
    // for (final uf in ufSeed) {
    //   await db.into(db.ufTable).insert(uf);
    // }
  }
}
