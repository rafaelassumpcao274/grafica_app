
import 'package:drift/drift.dart';

import '../../../domain/entities/clientes.dart' show Clientes;
import '../app_database.dart';

class ClientesMapper {

  static Clientes? toEntity(ClientesTableData? data) {
    if (data == null) return null;

    return Clientes(
      id: data.id,
      nomeEmpresa: data.nomeEmpresa,
      documento: data.documento,
      email: data.email,
      contato: data.contato,
      telefone: data.telefone,
    ); // Todos os campos agora podem ser opcionais na entidade
  }

  static ClientesTableCompanion? toCompanion(Clientes? entity) {
    if (entity == null) return null;

    return ClientesTableCompanion(
      id: Value(entity.id),
      nomeEmpresa: Value(entity.nomeEmpresa),
      documento: Value(entity.documento),
      email: entity.email != null ? Value(entity.email!) : const Value.absent(),
      contato: entity.contato != null
          ? Value(entity.contato!)
          : const Value.absent(),
      telefone: entity.telefone != null
          ? Value(entity.telefone!)
          : const Value.absent(),
    );
  }
}
