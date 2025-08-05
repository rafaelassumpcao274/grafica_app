import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/app_database.dart';
import '../../domain/entities/uf.dart';


final ufProvider = FutureProvider<List<Uf>>((ref) async {
  // Aguarda o banco estar pronto
  final db = await AppDatabase.getInstance();
  // Busca todas as siglas de UF
  final  result = await db.select(db.ufTable).get();
  return result.map((uf) => Uf(id:uf.id,descricao: uf.descricao,sigla: uf.sigla)).toList();
});
