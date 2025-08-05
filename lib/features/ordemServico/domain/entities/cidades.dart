import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Cidades extends Equatable {
  final String id;
  final String descricao;

  Cidades({
    String? id,
    required this.descricao,
  }) : id = id ?? const Uuid().v4();

  Cidades copyWith({String? descricao}) {
    return Cidades(
      id: id,
      descricao: descricao ?? this.descricao,
    );
  }

  @override
  List<Object?> get props => [id, descricao];
}
