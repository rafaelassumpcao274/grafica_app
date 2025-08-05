import '../entities/cidades.dart';

abstract class CidadesRepository {
  Future<List<Cidades>> getCidades();
  Future<void> addCidades(Cidades cidades);
  Future<void> updateCidades(Cidades cidades);
  Future<void> deleteCidades(String id);
}
