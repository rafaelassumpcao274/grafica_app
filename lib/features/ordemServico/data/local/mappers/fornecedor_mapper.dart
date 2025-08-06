
import 'package:drift/drift.dart';

import '../../../domain/entities/fornecedor.dart' show Fornecedor;
import '../app_database.dart';
class FornecedorMapper{


  static Fornecedor? toEntity(FornecedorTableData? data) {
    if(data == null ){
      return null;
    }

    return Fornecedor(
        id: data.id,
        nome: data.nome,
        contato: data.contato,
        telefone: data.telefone,
        email: data.email,
        observacao: data.observacao,
        tipoServico: data.tipoServico
    );
  }

  static FornecedorTableCompanion? toCompanion(Fornecedor? entity) {
    if(entity == null )return null;
    return FornecedorTableCompanion(
        id: Value(entity.id),
        nome: Value(entity.nome),
        contato: Value(entity.contato),
        telefone: Value(entity.telefone),
        email: Value(entity.email),
        observacao: Value(entity.observacao),
        tipoServico: Value(entity.tipoServico)
    );
  }

}
