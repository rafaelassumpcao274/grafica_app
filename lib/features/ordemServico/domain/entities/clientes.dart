import 'package:equatable/equatable.dart';
import 'package:unilith_app/features/ordemServico/domain/vos/documento.dart';
import 'package:unilith_app/features/ordemServico/presentation/core/formatter/document_formatter.dart';
import 'package:uuid/uuid.dart';

class Clientes extends Equatable {
  final String id;
  final String nomeEmpresa;
  final String documento;
  final String? email;
  final String? contato;
  final String? telefone;
  Documento doc;

  Clientes({
    String? id,
     String? nomeEmpresa,
     String? documento,
     this.email,
     this.contato,
     this.telefone,
     Documento? doc,
  }) : id = id ?? const Uuid().v4(),this.nomeEmpresa = nomeEmpresa ?? "",this.documento = documento ?? '',doc = doc ?? new Documento("");

  static Clientes  empty() => new Clientes();


  Clientes copyWith({
    String? nomeEmpresa,
    String? razaoSocial,
    String? documento,
    String? email,
    String? contato,
    String? telefone,
    Documento? doc,
  }) {
    return Clientes(
      id: id,
      nomeEmpresa: nomeEmpresa ?? this.nomeEmpresa,
      documento: documento ?? this.documento,
      email: email ?? this.email,
      contato: contato ?? this.contato,
      telefone: telefone ?? this.telefone, doc: doc?? this.doc,
    );
  }

  @override
  List<Object?> get props =>
      [id, nomeEmpresa,  documento, email, contato, telefone];


  String getDocumentFormatted() => DocumentFormatter.formatter(documento);

  @override
  String toString() => nomeEmpresa;

}


