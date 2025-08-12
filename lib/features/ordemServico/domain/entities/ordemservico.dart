import 'package:equatable/equatable.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/fornecedorOrdemServico.dart';


import 'clientes.dart';
import 'formato.dart';

class OrdemServico extends Equatable {
  final int id;
  final Clientes? clientes;
  final Formato? formato;
  final String material;
  final String corFrente;
  final String corVerso;
  final int quantidadeFolha;
  final bool possuiNumeracao;
  final int numeracaoInicial;
  final int numeracaoFinal;
  final String observacao;
  final double valorCusto;
  final double valorTotal;

  final List<FornecedorOrdemServico> fornecedores;

  OrdemServico({
    int? id,
    required this.material,
    required this.corFrente,
    required this.corVerso,
    required this.quantidadeFolha,
    this.possuiNumeracao = false,
    required this.numeracaoInicial,
    required this.numeracaoFinal,
    required this.observacao,
    this.clientes,
    this.formato,
    this.valorCusto = 0.0,
    this.valorTotal = 0.0,
    List<FornecedorOrdemServico>? fornecedores,
  })  : id = id ?? 0, fornecedores = fornecedores ?? [];

  OrdemServico copyWith({
    String? material,
    String? corFrente,
    String? corVerso,
    int? quantidadeFolha,
    bool? possuiNumeracao,
    int? numeracaoInicial,
    int? numeracaoFinal,
    String? observacao,
    Clientes? clientes,
    Formato? formato, 
    double? valorCusto,
    double? valorTotal,
    List<FornecedorOrdemServico>? fornecedores
  }) {
    return  OrdemServico(
      id: id,
      material: material ?? this.material,
      corFrente: corFrente ?? this.corFrente,
      corVerso: corVerso ?? this.corVerso,
      quantidadeFolha: quantidadeFolha ?? this.quantidadeFolha,
      possuiNumeracao: possuiNumeracao ?? this.possuiNumeracao,
      numeracaoInicial: numeracaoInicial ?? this.numeracaoInicial,
      numeracaoFinal: numeracaoFinal ?? this.numeracaoFinal,
      observacao: observacao ?? this.observacao,
      clientes: clientes,
      formato: formato,
      valorCusto: valorCusto ?? this.valorCusto,
      valorTotal: valorTotal ?? this.valorTotal,
      fornecedores: fornecedores ?? this.fornecedores
    );
  }

  @override
  List<Object?> get props => [
        id,
        clientes,
        formato,
        material,
        corFrente,
        corVerso,
        quantidadeFolha,
        numeracaoInicial,
        numeracaoFinal,
        observacao
        , possuiNumeracao,
        valorCusto,
        valorTotal,
        fornecedores
      ];
}
