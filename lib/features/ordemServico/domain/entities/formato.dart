import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Formato extends Equatable {
  final String id;
  final String descricao;

  Formato({
    String? id,
    required this.descricao,
  }) : id = id ?? const Uuid().v4();

  Formato copyWith({String? descricao}) {
    return Formato(
      id: id,
      descricao: descricao ?? this.descricao,
    );
  }

  @override
  List<Object?> get props => [id, descricao];
}
