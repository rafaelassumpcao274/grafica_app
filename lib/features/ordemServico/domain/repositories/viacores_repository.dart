import '../entities/via_cores.dart';

abstract class ViaCoresRepository {
  Future<List<ViaCores>> getViaCores();
    Future<List<ViaCores>> getViaCoresPaginated(
    {String search = '', int page = 1, int pageSize = 10}
  );
  Future<void> addViaCores(ViaCores viaCores);
  Future<void> updateViaCores(ViaCores viaCores);
  Future<void> deleteViaCores(String id);
}
