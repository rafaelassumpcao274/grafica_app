import 'package:equatable/equatable.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/fornecedor_ordem_servico.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/papel.dart';
import 'package:unilith_app/features/ordemServico/domain/entities/via_cores_ordem_servico.dart';
import 'package:unilith_app/features/ordemServico/domain/vos/tamanho.dart';


import 'clientes.dart';
import 'formato.dart';

class OrdemServico extends Equatable {
  final int id;
  final Clientes? clientes;
  final Formato? formato;
  final Papel? papel;
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
  final Tamanho? tamanhoImagem;
  final DateTime? createdAt;

  final List<FornecedorOrdemServico> fornecedores;
  final List<ViaCoresOrdemServico> vias;

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
    this.papel,
    this.valorCusto = 0.0,
    this.valorTotal = 0.0,
    List<FornecedorOrdemServico>? fornecedores,
    List<ViaCoresOrdemServico>? vias,
    Tamanho? tamanhoImagem,
    DateTime? createdAt
  })  : id = id ?? 0, fornecedores = fornecedores ?? [],tamanhoImagem = tamanhoImagem,vias = vias ?? [], createdAt = createdAt ?? DateTime.now();

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
    Papel? papel,
    double? valorCusto,
    double? valorTotal,
    List<FornecedorOrdemServico>? fornecedores,
    List<ViaCoresOrdemServico>? vias,
    Tamanho? tamanhoImagem,
    DateTime? createdAt
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
      papel: papel,
      valorCusto: valorCusto ?? this.valorCusto,
      valorTotal: valorTotal ?? this.valorTotal,
      fornecedores: fornecedores ?? this.fornecedores,
      vias: vias ?? this.vias,
        tamanhoImagem: tamanhoImagem ?? this.tamanhoImagem,
        createdAt: createdAt ?? DateTime.now()
    );
  }

  @override
  List<Object?> get props => [
        id,
        clientes,
        formato,
    papel,
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
        fornecedores,
        vias,
    tamanhoImagem,
    createdAt
      ];
}
