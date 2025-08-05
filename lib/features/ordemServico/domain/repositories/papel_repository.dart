import '../entities/papel.dart';

abstract class PapelRepository {
  Future<List<Papel>> getPapeis();
    Future<List<Papel>> getPapelPaginated(
    {String search = '', int page = 1, int pageSize = 10}
  );
  Future<void> addPapel(Papel papel);
  Future<void> updatePapel(Papel papel);
  Future<void> deletePapel(String id);
}
