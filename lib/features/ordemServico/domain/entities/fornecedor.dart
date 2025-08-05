import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Fornecedor extends Equatable {
  final String id;
  final String descricao;
  final double preco;

  Fornecedor({
    String? id,
    required this.descricao,
    required this.preco,
  }) : id = id ?? const Uuid().v4();

  Fornecedor copyWith({
    String? descricao,
    double? preco
  }) {
    return Fornecedor(
      id: id,
      descricao: descricao ?? this.descricao,
      preco: preco ?? this.preco
    );
  }

  @override
  List<Object?> get props => [id, descricao, preco];
}
