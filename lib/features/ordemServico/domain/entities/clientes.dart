import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Clientes extends Equatable {
  final String id;
  final String nomeEmpresa;
  final String documento;
  final String? email;
  final String? contato;
  final String? telefone;

  Clientes({
    String? id,
    required this.nomeEmpresa,
    required this.documento,
     this.email,
     this.contato,
     this.telefone,
  }) : id = id ?? const Uuid().v4();

  Clientes copyWith({
    String? nomeEmpresa,
    String? razaoSocial,
    String? documento,
    String? email,
    String? contato,
    String? telefone,
  }) {
    return Clientes(
      id: id,
      nomeEmpresa: nomeEmpresa ?? this.nomeEmpresa,
      documento: documento ?? this.documento,
      email: email ?? this.email,
      contato: contato ?? this.contato,
      telefone: telefone ?? this.telefone,
    );
  }

  @override
  List<Object?> get props =>
      [id, nomeEmpresa,  documento, email, contato, telefone];}
