import '../entities/uf.dart';

abstract class UfRepository {
  Future<List<Uf>> getUfs();
  Future<void> addUf(Uf uf);
  Future<void> updateUf(Uf uf);
  Future<void> deleteUf(String id);
}
