import '../entities/custo.dart';

abstract class CustoRepository {
  Future<List<Custo>> getCustos();
  Future<void> addCusto(Custo custo);
  Future<void> updateCusto(Custo custo);
  Future<void> deleteCusto(String id);
}
