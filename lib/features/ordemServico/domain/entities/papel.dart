import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Papel extends Equatable {
  final String id;
  final String descricao;
  final int quantidadePapel;

  Papel({
    String? id,
    required this.descricao,
    required this.quantidadePapel,
  }) : id = id ?? const Uuid().v4();

  Papel copyWith({String? descricao, int? quantidadePapel}) {
    return Papel(
      id: id,
      descricao: descricao ?? this.descricao,
      quantidadePapel: quantidadePapel ?? this.quantidadePapel,
    );
  }

  @override
  List<Object?> get props => [id, descricao, quantidadePapel];
}
