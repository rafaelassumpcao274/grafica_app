import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Enderecos extends Equatable {
  final String id;
  final String logradouro;
  final int cep;
  final String complemento;
  final int numero;

  Enderecos({
    String? id,
    required this.logradouro,
    required this.cep,
    required this.complemento,
    required this.numero,
  }) : id = id ?? const Uuid().v4();

  Enderecos copyWith({
    String? logradouro,
    int? cep,
    String? complemento,
    int? numero,
  }) {
    return Enderecos(
      id: id,
      logradouro: logradouro ?? this.logradouro,
      cep: cep ?? this.cep,
      complemento: complemento ?? this.complemento,
      numero: numero ?? this.numero,
    );
  }

  @override
  List<Object?> get props => [id, logradouro, cep, complemento, numero];
}
