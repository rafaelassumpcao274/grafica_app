import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/app_database.dart';
import '../../domain/entities/papel.dart';


final papelProvider = FutureProvider<List<Papel>>((ref) async {
  // Aguarda o banco estar pronto
  final db = await AppDatabase.getInstance();
  // Busca todas as siglas de UF
  final result = await db.select(db.papelTable).get();
  return result
      .map((papel) => Papel(
          id: papel.id,
          descricao: papel.descricao,
          quantidadePapel: papel.quantidadePapel))
      .toList();
});
