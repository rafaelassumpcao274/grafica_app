import '../entities/fornecedor.dart';

abstract class FornecedorRepository {
  Future<List<Fornecedor>> getFornecedores();
  Future<void> addFornecedor(Fornecedor fornecedor);
  Future<void> updateFornecedor(Fornecedor fornecedor);
  Future<void> deleteFornecedor(String id);
}
