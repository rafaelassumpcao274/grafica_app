import '../entities/fornecedor.dart';

abstract class FornecedorRepository {
  Future<List<Fornecedor>> getFornecedores();
  Future<void> add(Fornecedor fornecedor);
  Future<void> update(Fornecedor fornecedor);
  Future<void> delete(String id);
  Future<List<Fornecedor>> getFornecedorPaginated({
  String search = '',
  int page = 1,
  int pageSize = 10});
}
