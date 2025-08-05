import '../entities/formato.dart';

abstract class FormatoRepository {
  Future<List<Formato>> getFormatos();
  Future<List<Formato>> getFormatosPaginated(
    {String search = '', int page = 1, int pageSize = 10}
  );
  Future<void> addFormato(Formato formato);
  Future<void> updateFormato(Formato formato);
  Future<void> deleteFormato(String id);
}
