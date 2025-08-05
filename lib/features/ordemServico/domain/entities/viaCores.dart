import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class ViaCores extends Equatable {
  final String id;
  final String descricao;

  ViaCores({
    String? id,
    required this.descricao,
  }) : id = id ?? const Uuid().v4();

  ViaCores copyWith({String? descricao}) {
    return ViaCores(
      id: id,
      descricao: descricao ?? this.descricao,
    );
  }

  @override
  List<Object?> get props => [id, descricao];
}
