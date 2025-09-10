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
import 'config/sqlite_tipo_servico_converter.dart';
import 'migration/master.dart';
import 'tables/fornecedor_table.dart';
import 'tables/formato_table.dart';
import 'tables/viacores_table.dart';
import 'tables/papel_table.dart';
import 'tables/uf_table.dart';
import 'tables/clientes_table.dart';
import 'tables/ordemservico_table.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
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
  ViaCoresOrdemServicoTable
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
      1; // Não será usado, já que vamos aplicar migrações manuais

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {},
        onUpgrade: (migrator, from, to) async {},
        beforeOpen: (details) async {
          await master(this); // aplica os scripts no startup
          final formatosCount = await select(formatoTable).get();
          if (formatosCount.isEmpty) {
            await insertSeedData(this);
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
