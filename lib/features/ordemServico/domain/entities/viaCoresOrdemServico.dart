import 'package:equatable/equatable.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/fornecedor.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/ordemservico.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/via_cores.dart';
import 'package:uuid/uuid.dart';

class ViaCoresOrdemServico extends Equatable {
  final String id;
  final OrdemServico? ordemServico;
  final ViaCores? viaCores;
  final int ordem;

  ViaCoresOrdemServico(
      {String? id, this.ordemServico, this.viaCores, int? ordem})
      : id = id ?? const Uuid().v4(),
        ordem = ordem ?? 0;

  ViaCoresOrdemServico copyWith({
    OrdemServico? ordemServico,
    Fornecedor? fornecedor,
    double? custo,
  }) {
    return ViaCoresOrdemServico(
        id: id,
        ordemServico: ordemServico ?? this.ordemServico,
        viaCores: viaCores ?? this.viaCores,
        ordem: ordem ?? this.ordem);
  }

  @override
  List<Object?> get props => [id, ordemServico, viaCores, ordem];
}
