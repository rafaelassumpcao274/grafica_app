import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/local/app_database.dart';
import '../../data/local/repositories/clientes_repository_impl.dart';
import '../../domain/entities/clientes.dart';


final dbProvider = FutureProvider<AppDatabase>((ref) async {
  return await AppDatabase.getInstance();
});
final clientesRepositoryProvider =
    FutureProvider<ClientesRepositoryImpl>((ref) async {
  final db = await ref.watch(dbProvider.future);
  return ClientesRepositoryImpl(db);
});

class ClientesNotifier extends StateNotifier<List<Clientes>> {
  final ClientesRepositoryImpl repository;

  ClientesNotifier(this.repository) : super([]) {
    loadClientes();
  }

  Future<void> loadClientes() async {
    state = await repository.getClientes();
  }

  // MÉTODO CORRIGIDO: Use o parâmetro search do repository
  Future<List<Clientes>> getClientesByNomeEmpresa(String nomeParcial) async {
    print('🔍 Buscando por: "$nomeParcial"'); // Debug
    
    try {
      // CORREÇÃO: Passe o nomeParcial como search parameter
      final clientes = await repository.getClientesPaginated(
        search: nomeParcial,
        pageSize: 20, // Aumente o limite para pegar mais resultados
      );
      
      print('📊 Clientes encontrados: ${clientes.length}'); // Debug
      for (var c in clientes) {
        print('  - ${c.nomeEmpresa}');
      } // Debug
      
      return clientes;
    } catch (e) {
      print('❌ Erro na busca: $e'); // Debug
      rethrow;
    }
  }

  // Método alternativo caso você queira buscar em memória também
  Future<List<Clientes>> getClientesByNomeEmpresaAlternativo(String nomeParcial) async {
    print('🔍 Busca alternativa por: "$nomeParcial"'); // Debug
    
    try {
      // Opção 1: Busca direto no banco com filtro
      final clientesFiltrados = await repository.getClientesPaginated(
        search: nomeParcial,
        pageSize: 100,
      );
      
      if (clientesFiltrados.isNotEmpty) {
        return clientesFiltrados;
      }
      
      // Opção 2: Se não encontrar, busca todos e filtra em memória
      final todosClientes = await repository.getClientes();
      final resultado = todosClientes.where(
        (cliente) => cliente.nomeEmpresa.toLowerCase().contains(nomeParcial.toLowerCase()),
      ).toList();
      
      print('📊 Total encontrado: ${resultado.length}'); // Debug
      return resultado;
    } catch (e) {
      print('❌ Erro na busca: $e'); // Debug
      rethrow;
    }
  }

  // Outros métodos...
  Future<Clientes?> getClienteById(String id) async {
    final clientes = await repository.getClientes();
    try {
      return clientes.firstWhere((cliente) => cliente.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> addCliente(Clientes cliente) async {
    await repository.addClientes(cliente);
    await loadClientes();
  }

  Future<void> updateCliente(Clientes cliente) async {
    await repository.updateClientes(cliente);
    await loadClientes();
  }

  Future<void> deleteCliente(String id) async {
    await repository.deleteClientes(id);
    await loadClientes();
  }
}

final clientesNotifierProvider = FutureProvider<ClientesNotifier>((ref) async {
  final repository = await ref.watch(clientesRepositoryProvider.future);
  return ClientesNotifier(repository);
});



