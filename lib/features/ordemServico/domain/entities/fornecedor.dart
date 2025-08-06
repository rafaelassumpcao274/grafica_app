import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'enums/TipoServico.dart';

class Fornecedor extends Equatable {
  final String id;
  final String nome;
  final TipoServico tipoServico;
  final String contato;
  final String telefone;
  final String email;
  final String observacao;


  Fornecedor({
    String? id,
    required this.nome,
    required this.tipoServico,
    required this.contato,
    required this.telefone,
    required this.email,
    String? observacao,
  }) : id = id ?? const Uuid().v4(), observacao = observacao ?? "";

  Fornecedor copyWith({
    String? nome,
    TipoServico? tipoServico,
    String? contato,
    String? telefone,
    String? email,
    String? observacao,
  }) {
    return Fornecedor(
      id: id,
      nome: nome ?? this.nome,
      tipoServico: tipoServico ?? this.tipoServico,
      contato: contato ?? this.contato,
      telefone: telefone ?? this.telefone,
      email: email ?? this.email,
      observacao: observacao ?? this.observacao,
    );
  }

  @override
  List<Object?> get props => [id, nome,tipoServico,contato,telefone,email,observacao];
}
