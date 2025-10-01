import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/clientes.dart';
import '../../domain/provider/providers.dart';
import '../../domain/repositories/clientes_repository.dart';

class ClientesNotifier extends AsyncNotifier<List<Clientes>> {
  late final ClientesRepository repository;


  @override
  Future<List<Clientes>> build() async{
   repository = await ref.watch(clientesRepositoryProvider.future);
   return repository.getClientes();
  }



  Future<void> getClientesByNomeEmpresa(String nomeParcial) async {
    try {
      state = AsyncValue.data(await repository.getClientesPaginated(
         search: nomeParcial,
         pageSize: 20,
       ));
    } catch (e) {
      print('❌ Erro na busca: $e'); // Debug
      rethrow;
    }
  }


  Future<List<Clientes>> getClientesByNomeEmpresaAlternativo(String nomeParcial) async {
    try {

      final clientesFiltrados = await repository.getClientesPaginated(
        search: nomeParcial,
        pageSize: 100,
      );
      
      if (clientesFiltrados.isNotEmpty) {
        return clientesFiltrados;
      }

      final todosClientes = await repository.getClientes();
      final resultado = todosClientes.where(
        (cliente) => cliente.nomeEmpresa.toLowerCase().contains(nomeParcial.toLowerCase()),
      ).toList();

      return resultado;
    } catch (e) {
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
    state = AsyncValue.data(await repository.getClientes());
  }

  Future<void> updateCliente(Clientes cliente) async {
    await repository.updateClientes(cliente);
    state = AsyncValue.data(await repository.getClientes());
  }

  Future<void> deleteCliente(String id) async {
    await repository.deleteClientes(id);
    state = AsyncValue.data(await repository.getClientes());
  }
}

final clientesNotifierProvider = AsyncNotifierProvider<ClientesNotifier,List<Clientes>>(
    () => ClientesNotifier(),
);



