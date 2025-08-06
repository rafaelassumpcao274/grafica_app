import '../entities/fornecedor.dart';

abstract class FornecedorRepository {
  Future<List<Fornecedor>> getFornecedores();
  Future<void> add(Fornecedor fornecedor);
  Future<void> update(Fornecedor fornecedor);
  Future<void> delete(String id);
}
