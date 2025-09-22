import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/fornecedor.dart';
import 'package:unilith_app/features/ordemServico/domain/repositories/clientes_repository.dart';

import '../../domain/provider/providers.dart';
import '../../domain/repositories/fornecedor_repository.dart';



// Provider do Notifier
final fornecedorNotifierProvider =
AsyncNotifierProvider<FornecedorNotifier, List<Fornecedor>>(
      () => FornecedorNotifier(),
);


class FornecedorNotifier extends AsyncNotifier<List<Fornecedor>> {
  late final FornecedorRepository repository;

  @override
  Future<List<Fornecedor>> build() async {
    repository = await ref.watch(fornecedorRepositoryProvider.future);
    return repository.getFornecedores();
  }

  Future<void> addFornecedor(Fornecedor fornecedor) async {
    await repository.add(fornecedor);
    state = AsyncValue.data(await repository.getFornecedores());
  }

  Future<void> updateFornecedor(Fornecedor fornecedor) async {
    await repository.update(fornecedor);
    state = AsyncValue.data(await repository.getFornecedores());
  }

  Future<void> deleteFornecedor(String id) async {
    await repository.delete(id);
    state = AsyncValue.data(await repository.getFornecedores());
  }

  Future<List<Fornecedor>> getFornecedoresByNome(String nomeParcial) async {
    return repository.getFornecedorPaginated(search: nomeParcial, pageSize: 20);
  }

  Future<Fornecedor?> getById(String id) async {
    final fornecedores = await repository.getFornecedores();
    try {
      return fornecedores.firstWhere((fornecedor) => fornecedor.id == id);
    } catch (e) {
      state = AsyncValue.error(e,StackTrace.empty);
    }
  }
}






//
// class FornecedorNotifier extends StateNotifier<List<Fornecedor>> {
//   final FornecedorRepository repository;
//
//   FornecedorNotifier(this.repository) : super([]) {
//     loadFornecedores();
//   }
//
//   Future<void> loadFornecedores() async {
//     state = await repository.getFornecedores();
//   }
//
//   Future<Fornecedor?> getById(String id) async {
//     final fornecedores = await repository.getFornecedores();
//     try {
//       return fornecedores.firstWhere((fornecedor) => fornecedor.id == id);
//     } catch (e) {
//       return null;
//     }
//   }
//
//   Future<List<Fornecedor>> getFornecedoresByNome(String nomeParcial) async {
//     print('🔍 Buscando fornecedor por: "$nomeParcial"');
//     try {
//       final fornecedores = await repository.getFornecedorPaginated(
//         search: nomeParcial,
//         pageSize: 20,
//       );
//
//       print('📊 Fornecedores encontrados: ${fornecedores.length}');
//       for (var f in fornecedores) {
//         print('  - ${f.nome}');
//       }
//
//       return fornecedores;
//     } catch (e) {
//       print('❌ Erro na busca: $e');
//       rethrow;
//     }
//   }
//
//   Future<void> add(Fornecedor fornecedor) async {
//     await repository.add(fornecedor);
//     await loadFornecedores();
//   }
//
//   Future<void> updateFornecedor(Fornecedor fornecedor) async {
//     await repository.update(fornecedor);
//     await loadFornecedores();
//   }
//
//   Future<void> delete(String id) async {
//     await repository.delete(id);
//     await loadFornecedores();
//   }
// }
