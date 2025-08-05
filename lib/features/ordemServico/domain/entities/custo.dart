import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Custo extends Equatable {
  final String id;
  final String descricao;
  final double valor;

  Custo({
    String? id,
    required this.descricao,
    required this.valor,
  }) : id = id ?? const Uuid().v4();

  Custo copyWith({String? descricao, double? valor}) {
    return Custo(
      id: id,
      descricao: descricao ?? this.descricao,
      valor: valor ?? this.valor,
    );
  }

  @override
  List<Object?> get props => [id, descricao, valor];
}
