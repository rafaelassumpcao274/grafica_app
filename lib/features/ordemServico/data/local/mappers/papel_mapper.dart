import 'package:drift/drift.dart';

import '../../../domain/entities/papel.dart';
import '../app_database.dart';

class PapelMapper {

  static Papel? toEntity(PapelTableData? data) {
    if (data == null) return null;
    return Papel(
      id: data.id,
      descricao: data.descricao,
      quantidadePapel: data.quantidadePapel,
    );
  }

  static PapelTableCompanion? toCompanion(Papel? entity) {
    if (entity == null) return null;
    return PapelTableCompanion(
      id: Value(entity.id),
      descricao: Value(entity.descricao),
      quantidadePapel: Value(entity.quantidadePapel),
    );
  }

}

