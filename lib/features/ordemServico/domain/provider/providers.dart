import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/data/local/repositories/ordemservico_repository_impl.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/via_cores.dart';
import 'package:unilith_app/features/ordemServico/domain/repositories/ordemservico_repository.dart';

import '../../data/local/app_database.dart';
import '../../data/local/repositories/clientes_repository_impl.dart';
import '../../data/local/repositories/formato_repository_impl.dart';
import '../../data/local/repositories/fornecedor_repository_impl.dart';
import '../../data/local/repositories/papel_repository_impl.dart';
import '../../data/local/repositories/viacores_repository_impl.dart';
import '../repositories/clientes_repository.dart';
import '../repositories/formato_repository.dart';
import '../repositories/fornecedor_repository.dart';
import '../repositories/papel_repository.dart';
import '../repositories/viacores_repository.dart';

/// Provider do banco de dados
final dbProvider = FutureProvider<AppDatabase>((ref) async {
  return await AppDatabase.getInstance();
});

/// Provider do repositório de clientes
final clientesRepositoryProvider =
    FutureProvider<ClientesRepository>((ref) async {
  final db = await ref.watch(dbProvider.future);
  return ClientesRepositoryImpl(db);
});

final formatoRepositoryProvider =
    FutureProvider<FormatoRepository>((ref) async {
  final db = await ref.watch(dbProvider.future);
  return FormatoRepositoryImpl(db);
});

final fornecedorRepositoryProvider =
    FutureProvider<FornecedorRepository>((ref) async {
  final db = await ref.watch(dbProvider.future);
  return FornecedorRepositoryImpl(db);
});

final ordemServicoRepositoryProvider =
FutureProvider<OrdemServicoRepository>((ref) async {
  final db = await ref.watch(dbProvider.future);
  return OrdemServicoRepositoryImpl(db);
});

final papelRepositoryProvider =
FutureProvider<PapelRepository>((ref) async {
  final db = await ref.watch(dbProvider.future);
  return PapelRepositoryImpl(db);
});

final viaCoresRepositoryProvider =
FutureProvider<ViaCoresRepository>((ref) async {
  final db = await ref.watch(dbProvider.future);
  return ViaCoresRepositoryImpl(db);
});