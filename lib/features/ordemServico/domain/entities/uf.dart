import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Uf extends Equatable {
  final String id;
  final String descricao;
  final String sigla;

  Uf({
    String? id,
    required this.descricao,
    required this.sigla,
  }) : id = id ?? const Uuid().v4();

  Uf copyWith({String? descricao, String? sigla}) {
    return Uf(
      id: id,
      descricao: descricao ?? this.descricao,
      sigla: sigla ?? this.sigla,
    );
  }

  @override
  List<Object?> get props => [id, descricao, sigla];
}
