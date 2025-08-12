
  import 'package:equatable/equatable.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/fornecedor.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/ordemservico.dart';
import 'package:uuid/uuid.dart';

class FornecedorOrdemServico extends Equatable {
  final String id;
  final OrdemServico? ordemServico;
  final Fornecedor? fornecedor;
  final double custo;


  FornecedorOrdemServico({
  String? id,
   this.ordemServico,
   this.fornecedor,
   double? custo
  }) : id = id ?? const Uuid().v4(), custo = custo ?? 0.0;

  FornecedorOrdemServico copyWith({
  OrdemServico? ordemServico,
  Fornecedor? fornecedor,
  double? custo,
  }) {
  return FornecedorOrdemServico(
  id: id,
  ordemServico: ordemServico ?? this.ordemServico,
  fornecedor: fornecedor ?? this.fornecedor,
  custo: custo ?? this.custo
  );
  }

  @override
  List<Object?> get props => [id, ordemServico,fornecedor,custo];
}