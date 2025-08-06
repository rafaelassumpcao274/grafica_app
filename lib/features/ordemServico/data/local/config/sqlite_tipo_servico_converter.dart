 // ajuste o caminho do seu enum

import 'package:drift/drift.dart';

import '../../../domain/entities/enums/TipoServico.dart';

class SqliteTipoServicoConverter extends TypeConverter<TipoServico, String> {
  const SqliteTipoServicoConverter();

  @override
  TipoServico fromSql(String fromDb) {
    return TipoServico.values.firstWhere(
          (e) => e.name == fromDb,
      orElse: () => TipoServico.distribuidora, // Valor padrão, se necessário
    );
  }

  @override
  String toSql(TipoServico value) {
    return value.name;
  }
}
