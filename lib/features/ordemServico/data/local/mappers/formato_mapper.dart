
import 'package:drift/drift.dart';

import '../../../domain/entities/formato.dart' show Formato;
import '../app_database.dart';

class FormatoMapper {

  static Formato? toEntity(FormatoTableData? data) {
    if (data == null) return null;

    return Formato(
      id: data.id,
      descricao: data.descricao,
    );
  }

  static FormatoTableCompanion? toCompanion(Formato? entity) {
    if (entity == null) return null;

    return FormatoTableCompanion(
      id: Value(entity.id),
      descricao: Value(entity.descricao),
    );
  }
}
