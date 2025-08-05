import '../entities/clientes.dart';

abstract class ClientesRepository {
  Future<List<Clientes>> getClientes();
  Future<void> addClientes(Clientes clientes);
  Future<void> updateClientes(Clientes clientes);
  Future<void> deleteClientes(String id);
  Future<List<Clientes>> getClientesPaginated({
    String search,
    int page,
    int pageSize,
  });
}
