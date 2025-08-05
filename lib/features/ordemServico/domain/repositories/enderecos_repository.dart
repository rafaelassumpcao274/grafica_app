import '../entities/enderecos.dart';

abstract class EnderecosRepository {
  Future<List<Enderecos>> getEnderecos();
  Future<void> addEnderecos(Enderecos enderecos);
  Future<void> updateEnderecos(Enderecos enderecos);
  Future<void> deleteEnderecos(String id);
}
