// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FornecedorTableTable extends FornecedorTable
    with TableInfo<$FornecedorTableTable, FornecedorTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FornecedorTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => Uuid().v4());
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contatoMeta =
      const VerificationMeta('contato');
  @override
  late final GeneratedColumn<String> contato = GeneratedColumn<String>(
      'contato', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _telefoneMeta =
      const VerificationMeta('telefone');
  @override
  late final GeneratedColumn<String> telefone = GeneratedColumn<String>(
      'telefone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _observacaoMeta =
      const VerificationMeta('observacao');
  @override
  late final GeneratedColumn<String> observacao = GeneratedColumn<String>(
      'observacao', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<TipoServico, String> tipoServico =
      GeneratedColumn<String>('tipo_servico', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TipoServico>(
              $FornecedorTableTable.$convertertipoServico);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nome, contato, telefone, email, observacao, tipoServico];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fornecedor_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<FornecedorTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('contato')) {
      context.handle(_contatoMeta,
          contato.isAcceptableOrUnknown(data['contato']!, _contatoMeta));
    } else if (isInserting) {
      context.missing(_contatoMeta);
    }
    if (data.containsKey('telefone')) {
      context.handle(_telefoneMeta,
          telefone.isAcceptableOrUnknown(data['telefone']!, _telefoneMeta));
    } else if (isInserting) {
      context.missing(_telefoneMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('observacao')) {
      context.handle(
          _observacaoMeta,
          observacao.isAcceptableOrUnknown(
              data['observacao']!, _observacaoMeta));
    } else if (isInserting) {
      context.missing(_observacaoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FornecedorTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FornecedorTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      contato: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contato'])!,
      telefone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefone'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      observacao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacao'])!,
      tipoServico: $FornecedorTableTable.$convertertipoServico.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}tipo_servico'])!),
    );
  }

  @override
  $FornecedorTableTable createAlias(String alias) {
    return $FornecedorTableTable(attachedDatabase, alias);
  }

  static TypeConverter<TipoServico, String> $convertertipoServico =
      const SqliteTipoServicoConverter();
}

class FornecedorTableData extends DataClass
    implements Insertable<FornecedorTableData> {
  final String id;
  final String nome;
  final String contato;
  final String telefone;
  final String email;
  final String observacao;
  final TipoServico tipoServico;
  const FornecedorTableData(
      {required this.id,
      required this.nome,
      required this.contato,
      required this.telefone,
      required this.email,
      required this.observacao,
      required this.tipoServico});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nome'] = Variable<String>(nome);
    map['contato'] = Variable<String>(contato);
    map['telefone'] = Variable<String>(telefone);
    map['email'] = Variable<String>(email);
    map['observacao'] = Variable<String>(observacao);
    {
      map['tipo_servico'] = Variable<String>(
          $FornecedorTableTable.$convertertipoServico.toSql(tipoServico));
    }
    return map;
  }

  FornecedorTableCompanion toCompanion(bool nullToAbsent) {
    return FornecedorTableCompanion(
      id: Value(id),
      nome: Value(nome),
      contato: Value(contato),
      telefone: Value(telefone),
      email: Value(email),
      observacao: Value(observacao),
      tipoServico: Value(tipoServico),
    );
  }

  factory FornecedorTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FornecedorTableData(
      id: serializer.fromJson<String>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      contato: serializer.fromJson<String>(json['contato']),
      telefone: serializer.fromJson<String>(json['telefone']),
      email: serializer.fromJson<String>(json['email']),
      observacao: serializer.fromJson<String>(json['observacao']),
      tipoServico: serializer.fromJson<TipoServico>(json['tipoServico']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nome': serializer.toJson<String>(nome),
      'contato': serializer.toJson<String>(contato),
      'telefone': serializer.toJson<String>(telefone),
      'email': serializer.toJson<String>(email),
      'observacao': serializer.toJson<String>(observacao),
      'tipoServico': serializer.toJson<TipoServico>(tipoServico),
    };
  }

  FornecedorTableData copyWith(
          {String? id,
          String? nome,
          String? contato,
          String? telefone,
          String? email,
          String? observacao,
          TipoServico? tipoServico}) =>
      FornecedorTableData(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        contato: contato ?? this.contato,
        telefone: telefone ?? this.telefone,
        email: email ?? this.email,
        observacao: observacao ?? this.observacao,
        tipoServico: tipoServico ?? this.tipoServico,
      );
  FornecedorTableData copyWithCompanion(FornecedorTableCompanion data) {
    return FornecedorTableData(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      contato: data.contato.present ? data.contato.value : this.contato,
      telefone: data.telefone.present ? data.telefone.value : this.telefone,
      email: data.email.present ? data.email.value : this.email,
      observacao:
          data.observacao.present ? data.observacao.value : this.observacao,
      tipoServico:
          data.tipoServico.present ? data.tipoServico.value : this.tipoServico,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FornecedorTableData(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('contato: $contato, ')
          ..write('telefone: $telefone, ')
          ..write('email: $email, ')
          ..write('observacao: $observacao, ')
          ..write('tipoServico: $tipoServico')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nome, contato, telefone, email, observacao, tipoServico);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FornecedorTableData &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.contato == this.contato &&
          other.telefone == this.telefone &&
          other.email == this.email &&
          other.observacao == this.observacao &&
          other.tipoServico == this.tipoServico);
}

class FornecedorTableCompanion extends UpdateCompanion<FornecedorTableData> {
  final Value<String> id;
  final Value<String> nome;
  final Value<String> contato;
  final Value<String> telefone;
  final Value<String> email;
  final Value<String> observacao;
  final Value<TipoServico> tipoServico;
  final Value<int> rowid;
  const FornecedorTableCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.contato = const Value.absent(),
    this.telefone = const Value.absent(),
    this.email = const Value.absent(),
    this.observacao = const Value.absent(),
    this.tipoServico = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FornecedorTableCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    required String contato,
    required String telefone,
    required String email,
    required String observacao,
    required TipoServico tipoServico,
    this.rowid = const Value.absent(),
  })  : nome = Value(nome),
        contato = Value(contato),
        telefone = Value(telefone),
        email = Value(email),
        observacao = Value(observacao),
        tipoServico = Value(tipoServico);
  static Insertable<FornecedorTableData> custom({
    Expression<String>? id,
    Expression<String>? nome,
    Expression<String>? contato,
    Expression<String>? telefone,
    Expression<String>? email,
    Expression<String>? observacao,
    Expression<String>? tipoServico,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (contato != null) 'contato': contato,
      if (telefone != null) 'telefone': telefone,
      if (email != null) 'email': email,
      if (observacao != null) 'observacao': observacao,
      if (tipoServico != null) 'tipo_servico': tipoServico,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FornecedorTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? nome,
      Value<String>? contato,
      Value<String>? telefone,
      Value<String>? email,
      Value<String>? observacao,
      Value<TipoServico>? tipoServico,
      Value<int>? rowid}) {
    return FornecedorTableCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      contato: contato ?? this.contato,
      telefone: telefone ?? this.telefone,
      email: email ?? this.email,
      observacao: observacao ?? this.observacao,
      tipoServico: tipoServico ?? this.tipoServico,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (contato.present) {
      map['contato'] = Variable<String>(contato.value);
    }
    if (telefone.present) {
      map['telefone'] = Variable<String>(telefone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (observacao.present) {
      map['observacao'] = Variable<String>(observacao.value);
    }
    if (tipoServico.present) {
      map['tipo_servico'] = Variable<String>(
          $FornecedorTableTable.$convertertipoServico.toSql(tipoServico.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FornecedorTableCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('contato: $contato, ')
          ..write('telefone: $telefone, ')
          ..write('email: $email, ')
          ..write('observacao: $observacao, ')
          ..write('tipoServico: $tipoServico, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FormatoTableTable extends FormatoTable
    with TableInfo<$FormatoTableTable, FormatoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FormatoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => Uuid().v4());
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, descricao];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'formato_table';
  @override
  VerificationContext validateIntegrity(Insertable<FormatoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    } else if (isInserting) {
      context.missing(_descricaoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FormatoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FormatoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao'])!,
    );
  }

  @override
  $FormatoTableTable createAlias(String alias) {
    return $FormatoTableTable(attachedDatabase, alias);
  }
}

class FormatoTableData extends DataClass
    implements Insertable<FormatoTableData> {
  final String id;
  final String descricao;
  const FormatoTableData({required this.id, required this.descricao});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['descricao'] = Variable<String>(descricao);
    return map;
  }

  FormatoTableCompanion toCompanion(bool nullToAbsent) {
    return FormatoTableCompanion(
      id: Value(id),
      descricao: Value(descricao),
    );
  }

  factory FormatoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FormatoTableData(
      id: serializer.fromJson<String>(json['id']),
      descricao: serializer.fromJson<String>(json['descricao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'descricao': serializer.toJson<String>(descricao),
    };
  }

  FormatoTableData copyWith({String? id, String? descricao}) =>
      FormatoTableData(
        id: id ?? this.id,
        descricao: descricao ?? this.descricao,
      );
  FormatoTableData copyWithCompanion(FormatoTableCompanion data) {
    return FormatoTableData(
      id: data.id.present ? data.id.value : this.id,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FormatoTableData(')
          ..write('id: $id, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, descricao);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FormatoTableData &&
          other.id == this.id &&
          other.descricao == this.descricao);
}

class FormatoTableCompanion extends UpdateCompanion<FormatoTableData> {
  final Value<String> id;
  final Value<String> descricao;
  final Value<int> rowid;
  const FormatoTableCompanion({
    this.id = const Value.absent(),
    this.descricao = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FormatoTableCompanion.insert({
    this.id = const Value.absent(),
    required String descricao,
    this.rowid = const Value.absent(),
  }) : descricao = Value(descricao);
  static Insertable<FormatoTableData> custom({
    Expression<String>? id,
    Expression<String>? descricao,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (descricao != null) 'descricao': descricao,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FormatoTableCompanion copyWith(
      {Value<String>? id, Value<String>? descricao, Value<int>? rowid}) {
    return FormatoTableCompanion(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FormatoTableCompanion(')
          ..write('id: $id, ')
          ..write('descricao: $descricao, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ViaCoresTableTable extends ViaCoresTable
    with TableInfo<$ViaCoresTableTable, ViaCoresTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ViaCoresTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => Uuid().v4());
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, descricao];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'via_cores_table';
  @override
  VerificationContext validateIntegrity(Insertable<ViaCoresTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    } else if (isInserting) {
      context.missing(_descricaoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ViaCoresTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ViaCoresTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao'])!,
    );
  }

  @override
  $ViaCoresTableTable createAlias(String alias) {
    return $ViaCoresTableTable(attachedDatabase, alias);
  }
}

class ViaCoresTableData extends DataClass
    implements Insertable<ViaCoresTableData> {
  final String id;
  final String descricao;
  const ViaCoresTableData({required this.id, required this.descricao});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['descricao'] = Variable<String>(descricao);
    return map;
  }

  ViaCoresTableCompanion toCompanion(bool nullToAbsent) {
    return ViaCoresTableCompanion(
      id: Value(id),
      descricao: Value(descricao),
    );
  }

  factory ViaCoresTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ViaCoresTableData(
      id: serializer.fromJson<String>(json['id']),
      descricao: serializer.fromJson<String>(json['descricao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'descricao': serializer.toJson<String>(descricao),
    };
  }

  ViaCoresTableData copyWith({String? id, String? descricao}) =>
      ViaCoresTableData(
        id: id ?? this.id,
        descricao: descricao ?? this.descricao,
      );
  ViaCoresTableData copyWithCompanion(ViaCoresTableCompanion data) {
    return ViaCoresTableData(
      id: data.id.present ? data.id.value : this.id,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ViaCoresTableData(')
          ..write('id: $id, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, descricao);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ViaCoresTableData &&
          other.id == this.id &&
          other.descricao == this.descricao);
}

class ViaCoresTableCompanion extends UpdateCompanion<ViaCoresTableData> {
  final Value<String> id;
  final Value<String> descricao;
  final Value<int> rowid;
  const ViaCoresTableCompanion({
    this.id = const Value.absent(),
    this.descricao = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ViaCoresTableCompanion.insert({
    this.id = const Value.absent(),
    required String descricao,
    this.rowid = const Value.absent(),
  }) : descricao = Value(descricao);
  static Insertable<ViaCoresTableData> custom({
    Expression<String>? id,
    Expression<String>? descricao,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (descricao != null) 'descricao': descricao,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ViaCoresTableCompanion copyWith(
      {Value<String>? id, Value<String>? descricao, Value<int>? rowid}) {
    return ViaCoresTableCompanion(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ViaCoresTableCompanion(')
          ..write('id: $id, ')
          ..write('descricao: $descricao, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PapelTableTable extends PapelTable
    with TableInfo<$PapelTableTable, PapelTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PapelTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => Uuid().v4());
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantidadePapelMeta =
      const VerificationMeta('quantidadePapel');
  @override
  late final GeneratedColumn<int> quantidadePapel = GeneratedColumn<int>(
      'quantidade_papel', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, descricao, quantidadePapel];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'papel_table';
  @override
  VerificationContext validateIntegrity(Insertable<PapelTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    } else if (isInserting) {
      context.missing(_descricaoMeta);
    }
    if (data.containsKey('quantidade_papel')) {
      context.handle(
          _quantidadePapelMeta,
          quantidadePapel.isAcceptableOrUnknown(
              data['quantidade_papel']!, _quantidadePapelMeta));
    } else if (isInserting) {
      context.missing(_quantidadePapelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PapelTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PapelTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao'])!,
      quantidadePapel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantidade_papel'])!,
    );
  }

  @override
  $PapelTableTable createAlias(String alias) {
    return $PapelTableTable(attachedDatabase, alias);
  }
}

class PapelTableData extends DataClass implements Insertable<PapelTableData> {
  final String id;
  final String descricao;
  final int quantidadePapel;
  const PapelTableData(
      {required this.id,
      required this.descricao,
      required this.quantidadePapel});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['descricao'] = Variable<String>(descricao);
    map['quantidade_papel'] = Variable<int>(quantidadePapel);
    return map;
  }

  PapelTableCompanion toCompanion(bool nullToAbsent) {
    return PapelTableCompanion(
      id: Value(id),
      descricao: Value(descricao),
      quantidadePapel: Value(quantidadePapel),
    );
  }

  factory PapelTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PapelTableData(
      id: serializer.fromJson<String>(json['id']),
      descricao: serializer.fromJson<String>(json['descricao']),
      quantidadePapel: serializer.fromJson<int>(json['quantidadePapel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'descricao': serializer.toJson<String>(descricao),
      'quantidadePapel': serializer.toJson<int>(quantidadePapel),
    };
  }

  PapelTableData copyWith(
          {String? id, String? descricao, int? quantidadePapel}) =>
      PapelTableData(
        id: id ?? this.id,
        descricao: descricao ?? this.descricao,
        quantidadePapel: quantidadePapel ?? this.quantidadePapel,
      );
  PapelTableData copyWithCompanion(PapelTableCompanion data) {
    return PapelTableData(
      id: data.id.present ? data.id.value : this.id,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
      quantidadePapel: data.quantidadePapel.present
          ? data.quantidadePapel.value
          : this.quantidadePapel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PapelTableData(')
          ..write('id: $id, ')
          ..write('descricao: $descricao, ')
          ..write('quantidadePapel: $quantidadePapel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, descricao, quantidadePapel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PapelTableData &&
          other.id == this.id &&
          other.descricao == this.descricao &&
          other.quantidadePapel == this.quantidadePapel);
}

class PapelTableCompanion extends UpdateCompanion<PapelTableData> {
  final Value<String> id;
  final Value<String> descricao;
  final Value<int> quantidadePapel;
  final Value<int> rowid;
  const PapelTableCompanion({
    this.id = const Value.absent(),
    this.descricao = const Value.absent(),
    this.quantidadePapel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PapelTableCompanion.insert({
    this.id = const Value.absent(),
    required String descricao,
    required int quantidadePapel,
    this.rowid = const Value.absent(),
  })  : descricao = Value(descricao),
        quantidadePapel = Value(quantidadePapel);
  static Insertable<PapelTableData> custom({
    Expression<String>? id,
    Expression<String>? descricao,
    Expression<int>? quantidadePapel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (descricao != null) 'descricao': descricao,
      if (quantidadePapel != null) 'quantidade_papel': quantidadePapel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PapelTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? descricao,
      Value<int>? quantidadePapel,
      Value<int>? rowid}) {
    return PapelTableCompanion(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      quantidadePapel: quantidadePapel ?? this.quantidadePapel,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    if (quantidadePapel.present) {
      map['quantidade_papel'] = Variable<int>(quantidadePapel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PapelTableCompanion(')
          ..write('id: $id, ')
          ..write('descricao: $descricao, ')
          ..write('quantidadePapel: $quantidadePapel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UfTableTable extends UfTable with TableInfo<$UfTableTable, UfTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UfTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => Uuid().v4());
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _siglaMeta = const VerificationMeta('sigla');
  @override
  late final GeneratedColumn<String> sigla = GeneratedColumn<String>(
      'sigla', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, descricao, sigla];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'uf_table';
  @override
  VerificationContext validateIntegrity(Insertable<UfTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    } else if (isInserting) {
      context.missing(_descricaoMeta);
    }
    if (data.containsKey('sigla')) {
      context.handle(
          _siglaMeta, sigla.isAcceptableOrUnknown(data['sigla']!, _siglaMeta));
    } else if (isInserting) {
      context.missing(_siglaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UfTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UfTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao'])!,
      sigla: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sigla'])!,
    );
  }

  @override
  $UfTableTable createAlias(String alias) {
    return $UfTableTable(attachedDatabase, alias);
  }
}

class UfTableData extends DataClass implements Insertable<UfTableData> {
  final String id;
  final String descricao;
  final String sigla;
  const UfTableData(
      {required this.id, required this.descricao, required this.sigla});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['descricao'] = Variable<String>(descricao);
    map['sigla'] = Variable<String>(sigla);
    return map;
  }

  UfTableCompanion toCompanion(bool nullToAbsent) {
    return UfTableCompanion(
      id: Value(id),
      descricao: Value(descricao),
      sigla: Value(sigla),
    );
  }

  factory UfTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UfTableData(
      id: serializer.fromJson<String>(json['id']),
      descricao: serializer.fromJson<String>(json['descricao']),
      sigla: serializer.fromJson<String>(json['sigla']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'descricao': serializer.toJson<String>(descricao),
      'sigla': serializer.toJson<String>(sigla),
    };
  }

  UfTableData copyWith({String? id, String? descricao, String? sigla}) =>
      UfTableData(
        id: id ?? this.id,
        descricao: descricao ?? this.descricao,
        sigla: sigla ?? this.sigla,
      );
  UfTableData copyWithCompanion(UfTableCompanion data) {
    return UfTableData(
      id: data.id.present ? data.id.value : this.id,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
      sigla: data.sigla.present ? data.sigla.value : this.sigla,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UfTableData(')
          ..write('id: $id, ')
          ..write('descricao: $descricao, ')
          ..write('sigla: $sigla')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, descricao, sigla);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UfTableData &&
          other.id == this.id &&
          other.descricao == this.descricao &&
          other.sigla == this.sigla);
}

class UfTableCompanion extends UpdateCompanion<UfTableData> {
  final Value<String> id;
  final Value<String> descricao;
  final Value<String> sigla;
  final Value<int> rowid;
  const UfTableCompanion({
    this.id = const Value.absent(),
    this.descricao = const Value.absent(),
    this.sigla = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UfTableCompanion.insert({
    this.id = const Value.absent(),
    required String descricao,
    required String sigla,
    this.rowid = const Value.absent(),
  })  : descricao = Value(descricao),
        sigla = Value(sigla);
  static Insertable<UfTableData> custom({
    Expression<String>? id,
    Expression<String>? descricao,
    Expression<String>? sigla,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (descricao != null) 'descricao': descricao,
      if (sigla != null) 'sigla': sigla,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UfTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? descricao,
      Value<String>? sigla,
      Value<int>? rowid}) {
    return UfTableCompanion(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      sigla: sigla ?? this.sigla,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    if (sigla.present) {
      map['sigla'] = Variable<String>(sigla.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UfTableCompanion(')
          ..write('id: $id, ')
          ..write('descricao: $descricao, ')
          ..write('sigla: $sigla, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClientesTableTable extends ClientesTable
    with TableInfo<$ClientesTableTable, ClientesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => Uuid().v4());
  static const VerificationMeta _nomeEmpresaMeta =
      const VerificationMeta('nomeEmpresa');
  @override
  late final GeneratedColumn<String> nomeEmpresa = GeneratedColumn<String>(
      'nome_empresa', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _documentoMeta =
      const VerificationMeta('documento');
  @override
  late final GeneratedColumn<String> documento = GeneratedColumn<String>(
      'documento', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 14),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contatoMeta =
      const VerificationMeta('contato');
  @override
  late final GeneratedColumn<String> contato = GeneratedColumn<String>(
      'contato', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _telefoneMeta =
      const VerificationMeta('telefone');
  @override
  late final GeneratedColumn<String> telefone = GeneratedColumn<String>(
      'telefone', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 11),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nomeEmpresa, documento, email, contato, telefone];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clientes_table';
  @override
  VerificationContext validateIntegrity(Insertable<ClientesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome_empresa')) {
      context.handle(
          _nomeEmpresaMeta,
          nomeEmpresa.isAcceptableOrUnknown(
              data['nome_empresa']!, _nomeEmpresaMeta));
    } else if (isInserting) {
      context.missing(_nomeEmpresaMeta);
    }
    if (data.containsKey('documento')) {
      context.handle(_documentoMeta,
          documento.isAcceptableOrUnknown(data['documento']!, _documentoMeta));
    } else if (isInserting) {
      context.missing(_documentoMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('contato')) {
      context.handle(_contatoMeta,
          contato.isAcceptableOrUnknown(data['contato']!, _contatoMeta));
    }
    if (data.containsKey('telefone')) {
      context.handle(_telefoneMeta,
          telefone.isAcceptableOrUnknown(data['telefone']!, _telefoneMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClientesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClientesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nomeEmpresa: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome_empresa'])!,
      documento: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}documento'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      contato: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contato']),
      telefone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefone']),
    );
  }

  @override
  $ClientesTableTable createAlias(String alias) {
    return $ClientesTableTable(attachedDatabase, alias);
  }
}

class ClientesTableData extends DataClass
    implements Insertable<ClientesTableData> {
  final String id;
  final String nomeEmpresa;
  final String documento;
  final String? email;
  final String? contato;
  final String? telefone;
  const ClientesTableData(
      {required this.id,
      required this.nomeEmpresa,
      required this.documento,
      this.email,
      this.contato,
      this.telefone});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nome_empresa'] = Variable<String>(nomeEmpresa);
    map['documento'] = Variable<String>(documento);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || contato != null) {
      map['contato'] = Variable<String>(contato);
    }
    if (!nullToAbsent || telefone != null) {
      map['telefone'] = Variable<String>(telefone);
    }
    return map;
  }

  ClientesTableCompanion toCompanion(bool nullToAbsent) {
    return ClientesTableCompanion(
      id: Value(id),
      nomeEmpresa: Value(nomeEmpresa),
      documento: Value(documento),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      contato: contato == null && nullToAbsent
          ? const Value.absent()
          : Value(contato),
      telefone: telefone == null && nullToAbsent
          ? const Value.absent()
          : Value(telefone),
    );
  }

  factory ClientesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientesTableData(
      id: serializer.fromJson<String>(json['id']),
      nomeEmpresa: serializer.fromJson<String>(json['nomeEmpresa']),
      documento: serializer.fromJson<String>(json['documento']),
      email: serializer.fromJson<String?>(json['email']),
      contato: serializer.fromJson<String?>(json['contato']),
      telefone: serializer.fromJson<String?>(json['telefone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nomeEmpresa': serializer.toJson<String>(nomeEmpresa),
      'documento': serializer.toJson<String>(documento),
      'email': serializer.toJson<String?>(email),
      'contato': serializer.toJson<String?>(contato),
      'telefone': serializer.toJson<String?>(telefone),
    };
  }

  ClientesTableData copyWith(
          {String? id,
          String? nomeEmpresa,
          String? documento,
          Value<String?> email = const Value.absent(),
          Value<String?> contato = const Value.absent(),
          Value<String?> telefone = const Value.absent()}) =>
      ClientesTableData(
        id: id ?? this.id,
        nomeEmpresa: nomeEmpresa ?? this.nomeEmpresa,
        documento: documento ?? this.documento,
        email: email.present ? email.value : this.email,
        contato: contato.present ? contato.value : this.contato,
        telefone: telefone.present ? telefone.value : this.telefone,
      );
  ClientesTableData copyWithCompanion(ClientesTableCompanion data) {
    return ClientesTableData(
      id: data.id.present ? data.id.value : this.id,
      nomeEmpresa:
          data.nomeEmpresa.present ? data.nomeEmpresa.value : this.nomeEmpresa,
      documento: data.documento.present ? data.documento.value : this.documento,
      email: data.email.present ? data.email.value : this.email,
      contato: data.contato.present ? data.contato.value : this.contato,
      telefone: data.telefone.present ? data.telefone.value : this.telefone,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClientesTableData(')
          ..write('id: $id, ')
          ..write('nomeEmpresa: $nomeEmpresa, ')
          ..write('documento: $documento, ')
          ..write('email: $email, ')
          ..write('contato: $contato, ')
          ..write('telefone: $telefone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nomeEmpresa, documento, email, contato, telefone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientesTableData &&
          other.id == this.id &&
          other.nomeEmpresa == this.nomeEmpresa &&
          other.documento == this.documento &&
          other.email == this.email &&
          other.contato == this.contato &&
          other.telefone == this.telefone);
}

class ClientesTableCompanion extends UpdateCompanion<ClientesTableData> {
  final Value<String> id;
  final Value<String> nomeEmpresa;
  final Value<String> documento;
  final Value<String?> email;
  final Value<String?> contato;
  final Value<String?> telefone;
  final Value<int> rowid;
  const ClientesTableCompanion({
    this.id = const Value.absent(),
    this.nomeEmpresa = const Value.absent(),
    this.documento = const Value.absent(),
    this.email = const Value.absent(),
    this.contato = const Value.absent(),
    this.telefone = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientesTableCompanion.insert({
    this.id = const Value.absent(),
    required String nomeEmpresa,
    required String documento,
    this.email = const Value.absent(),
    this.contato = const Value.absent(),
    this.telefone = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : nomeEmpresa = Value(nomeEmpresa),
        documento = Value(documento);
  static Insertable<ClientesTableData> custom({
    Expression<String>? id,
    Expression<String>? nomeEmpresa,
    Expression<String>? documento,
    Expression<String>? email,
    Expression<String>? contato,
    Expression<String>? telefone,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nomeEmpresa != null) 'nome_empresa': nomeEmpresa,
      if (documento != null) 'documento': documento,
      if (email != null) 'email': email,
      if (contato != null) 'contato': contato,
      if (telefone != null) 'telefone': telefone,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? nomeEmpresa,
      Value<String>? documento,
      Value<String?>? email,
      Value<String?>? contato,
      Value<String?>? telefone,
      Value<int>? rowid}) {
    return ClientesTableCompanion(
      id: id ?? this.id,
      nomeEmpresa: nomeEmpresa ?? this.nomeEmpresa,
      documento: documento ?? this.documento,
      email: email ?? this.email,
      contato: contato ?? this.contato,
      telefone: telefone ?? this.telefone,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nomeEmpresa.present) {
      map['nome_empresa'] = Variable<String>(nomeEmpresa.value);
    }
    if (documento.present) {
      map['documento'] = Variable<String>(documento.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (contato.present) {
      map['contato'] = Variable<String>(contato.value);
    }
    if (telefone.present) {
      map['telefone'] = Variable<String>(telefone.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientesTableCompanion(')
          ..write('id: $id, ')
          ..write('nomeEmpresa: $nomeEmpresa, ')
          ..write('documento: $documento, ')
          ..write('email: $email, ')
          ..write('contato: $contato, ')
          ..write('telefone: $telefone, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrdemServicoTableTable extends OrdemServicoTable
    with TableInfo<$OrdemServicoTableTable, OrdemServicoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdemServicoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _clienteIdMeta =
      const VerificationMeta('clienteId');
  @override
  late final GeneratedColumn<String> clienteId = GeneratedColumn<String>(
      'cliente_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES clientes_table (id)'));
  static const VerificationMeta _formatoIdMeta =
      const VerificationMeta('formatoId');
  @override
  late final GeneratedColumn<String> formatoId = GeneratedColumn<String>(
      'formato_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES formato_table (id)'));
  static const VerificationMeta _materialMeta =
      const VerificationMeta('material');
  @override
  late final GeneratedColumn<String> material = GeneratedColumn<String>(
      'material', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _corFrenteMeta =
      const VerificationMeta('corFrente');
  @override
  late final GeneratedColumn<String> corFrente = GeneratedColumn<String>(
      'cor_frente', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _corVersoMeta =
      const VerificationMeta('corVerso');
  @override
  late final GeneratedColumn<String> corVerso = GeneratedColumn<String>(
      'cor_verso', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantidadeFolhaMeta =
      const VerificationMeta('quantidadeFolha');
  @override
  late final GeneratedColumn<int> quantidadeFolha = GeneratedColumn<int>(
      'quantidade_folha', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _possuiNumeracaoMeta =
      const VerificationMeta('possuiNumeracao');
  @override
  late final GeneratedColumn<bool> possuiNumeracao = GeneratedColumn<bool>(
      'possui_numeracao', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("possui_numeracao" IN (0, 1))'),
      defaultValue: Constant(false));
  static const VerificationMeta _numeracaoInicialMeta =
      const VerificationMeta('numeracaoInicial');
  @override
  late final GeneratedColumn<int> numeracaoInicial = GeneratedColumn<int>(
      'numeracao_inicial', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _numeracaoFinalMeta =
      const VerificationMeta('numeracaoFinal');
  @override
  late final GeneratedColumn<int> numeracaoFinal = GeneratedColumn<int>(
      'numeracao_final', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _observacaoMeta =
      const VerificationMeta('observacao');
  @override
  late final GeneratedColumn<String> observacao = GeneratedColumn<String>(
      'observacao', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valorCustoMeta =
      const VerificationMeta('valorCusto');
  @override
  late final GeneratedColumn<double> valorCusto = GeneratedColumn<double>(
      'valor_custo', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: Constant(0.0));
  static const VerificationMeta _valorTotalMeta =
      const VerificationMeta('valorTotal');
  @override
  late final GeneratedColumn<double> valorTotal = GeneratedColumn<double>(
      'valor_total', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: Constant(0.0));
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, String> createdAt =
      GeneratedColumn<String>('created_at', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('CURRENT_TIMESTAMP'))
          .withConverter<DateTime>($OrdemServicoTableTable.$convertercreatedAt);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        clienteId,
        formatoId,
        material,
        corFrente,
        corVerso,
        quantidadeFolha,
        possuiNumeracao,
        numeracaoInicial,
        numeracaoFinal,
        observacao,
        valorCusto,
        valorTotal,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ordem_servico_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<OrdemServicoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cliente_id')) {
      context.handle(_clienteIdMeta,
          clienteId.isAcceptableOrUnknown(data['cliente_id']!, _clienteIdMeta));
    } else if (isInserting) {
      context.missing(_clienteIdMeta);
    }
    if (data.containsKey('formato_id')) {
      context.handle(_formatoIdMeta,
          formatoId.isAcceptableOrUnknown(data['formato_id']!, _formatoIdMeta));
    }
    if (data.containsKey('material')) {
      context.handle(_materialMeta,
          material.isAcceptableOrUnknown(data['material']!, _materialMeta));
    } else if (isInserting) {
      context.missing(_materialMeta);
    }
    if (data.containsKey('cor_frente')) {
      context.handle(_corFrenteMeta,
          corFrente.isAcceptableOrUnknown(data['cor_frente']!, _corFrenteMeta));
    } else if (isInserting) {
      context.missing(_corFrenteMeta);
    }
    if (data.containsKey('cor_verso')) {
      context.handle(_corVersoMeta,
          corVerso.isAcceptableOrUnknown(data['cor_verso']!, _corVersoMeta));
    } else if (isInserting) {
      context.missing(_corVersoMeta);
    }
    if (data.containsKey('quantidade_folha')) {
      context.handle(
          _quantidadeFolhaMeta,
          quantidadeFolha.isAcceptableOrUnknown(
              data['quantidade_folha']!, _quantidadeFolhaMeta));
    } else if (isInserting) {
      context.missing(_quantidadeFolhaMeta);
    }
    if (data.containsKey('possui_numeracao')) {
      context.handle(
          _possuiNumeracaoMeta,
          possuiNumeracao.isAcceptableOrUnknown(
              data['possui_numeracao']!, _possuiNumeracaoMeta));
    }
    if (data.containsKey('numeracao_inicial')) {
      context.handle(
          _numeracaoInicialMeta,
          numeracaoInicial.isAcceptableOrUnknown(
              data['numeracao_inicial']!, _numeracaoInicialMeta));
    } else if (isInserting) {
      context.missing(_numeracaoInicialMeta);
    }
    if (data.containsKey('numeracao_final')) {
      context.handle(
          _numeracaoFinalMeta,
          numeracaoFinal.isAcceptableOrUnknown(
              data['numeracao_final']!, _numeracaoFinalMeta));
    } else if (isInserting) {
      context.missing(_numeracaoFinalMeta);
    }
    if (data.containsKey('observacao')) {
      context.handle(
          _observacaoMeta,
          observacao.isAcceptableOrUnknown(
              data['observacao']!, _observacaoMeta));
    } else if (isInserting) {
      context.missing(_observacaoMeta);
    }
    if (data.containsKey('valor_custo')) {
      context.handle(
          _valorCustoMeta,
          valorCusto.isAcceptableOrUnknown(
              data['valor_custo']!, _valorCustoMeta));
    }
    if (data.containsKey('valor_total')) {
      context.handle(
          _valorTotalMeta,
          valorTotal.isAcceptableOrUnknown(
              data['valor_total']!, _valorTotalMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrdemServicoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrdemServicoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      clienteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cliente_id'])!,
      formatoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}formato_id']),
      material: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}material'])!,
      corFrente: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cor_frente'])!,
      corVerso: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cor_verso'])!,
      quantidadeFolha: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantidade_folha'])!,
      possuiNumeracao: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}possui_numeracao'])!,
      numeracaoInicial: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}numeracao_inicial'])!,
      numeracaoFinal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}numeracao_final'])!,
      observacao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacao'])!,
      valorCusto: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valor_custo'])!,
      valorTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valor_total'])!,
      createdAt: $OrdemServicoTableTable.$convertercreatedAt.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}created_at'])!),
    );
  }

  @override
  $OrdemServicoTableTable createAlias(String alias) {
    return $OrdemServicoTableTable(attachedDatabase, alias);
  }

  static TypeConverter<DateTime, String> $convertercreatedAt =
      const SqliteDateTimeConverter();
}

class OrdemServicoTableData extends DataClass
    implements Insertable<OrdemServicoTableData> {
  final int id;
  final String clienteId;
  final String? formatoId;
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
  final DateTime createdAt;
  const OrdemServicoTableData(
      {required this.id,
      required this.clienteId,
      this.formatoId,
      required this.material,
      required this.corFrente,
      required this.corVerso,
      required this.quantidadeFolha,
      required this.possuiNumeracao,
      required this.numeracaoInicial,
      required this.numeracaoFinal,
      required this.observacao,
      required this.valorCusto,
      required this.valorTotal,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cliente_id'] = Variable<String>(clienteId);
    if (!nullToAbsent || formatoId != null) {
      map['formato_id'] = Variable<String>(formatoId);
    }
    map['material'] = Variable<String>(material);
    map['cor_frente'] = Variable<String>(corFrente);
    map['cor_verso'] = Variable<String>(corVerso);
    map['quantidade_folha'] = Variable<int>(quantidadeFolha);
    map['possui_numeracao'] = Variable<bool>(possuiNumeracao);
    map['numeracao_inicial'] = Variable<int>(numeracaoInicial);
    map['numeracao_final'] = Variable<int>(numeracaoFinal);
    map['observacao'] = Variable<String>(observacao);
    map['valor_custo'] = Variable<double>(valorCusto);
    map['valor_total'] = Variable<double>(valorTotal);
    {
      map['created_at'] = Variable<String>(
          $OrdemServicoTableTable.$convertercreatedAt.toSql(createdAt));
    }
    return map;
  }

  OrdemServicoTableCompanion toCompanion(bool nullToAbsent) {
    return OrdemServicoTableCompanion(
      id: Value(id),
      clienteId: Value(clienteId),
      formatoId: formatoId == null && nullToAbsent
          ? const Value.absent()
          : Value(formatoId),
      material: Value(material),
      corFrente: Value(corFrente),
      corVerso: Value(corVerso),
      quantidadeFolha: Value(quantidadeFolha),
      possuiNumeracao: Value(possuiNumeracao),
      numeracaoInicial: Value(numeracaoInicial),
      numeracaoFinal: Value(numeracaoFinal),
      observacao: Value(observacao),
      valorCusto: Value(valorCusto),
      valorTotal: Value(valorTotal),
      createdAt: Value(createdAt),
    );
  }

  factory OrdemServicoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrdemServicoTableData(
      id: serializer.fromJson<int>(json['id']),
      clienteId: serializer.fromJson<String>(json['clienteId']),
      formatoId: serializer.fromJson<String?>(json['formatoId']),
      material: serializer.fromJson<String>(json['material']),
      corFrente: serializer.fromJson<String>(json['corFrente']),
      corVerso: serializer.fromJson<String>(json['corVerso']),
      quantidadeFolha: serializer.fromJson<int>(json['quantidadeFolha']),
      possuiNumeracao: serializer.fromJson<bool>(json['possuiNumeracao']),
      numeracaoInicial: serializer.fromJson<int>(json['numeracaoInicial']),
      numeracaoFinal: serializer.fromJson<int>(json['numeracaoFinal']),
      observacao: serializer.fromJson<String>(json['observacao']),
      valorCusto: serializer.fromJson<double>(json['valorCusto']),
      valorTotal: serializer.fromJson<double>(json['valorTotal']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clienteId': serializer.toJson<String>(clienteId),
      'formatoId': serializer.toJson<String?>(formatoId),
      'material': serializer.toJson<String>(material),
      'corFrente': serializer.toJson<String>(corFrente),
      'corVerso': serializer.toJson<String>(corVerso),
      'quantidadeFolha': serializer.toJson<int>(quantidadeFolha),
      'possuiNumeracao': serializer.toJson<bool>(possuiNumeracao),
      'numeracaoInicial': serializer.toJson<int>(numeracaoInicial),
      'numeracaoFinal': serializer.toJson<int>(numeracaoFinal),
      'observacao': serializer.toJson<String>(observacao),
      'valorCusto': serializer.toJson<double>(valorCusto),
      'valorTotal': serializer.toJson<double>(valorTotal),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  OrdemServicoTableData copyWith(
          {int? id,
          String? clienteId,
          Value<String?> formatoId = const Value.absent(),
          String? material,
          String? corFrente,
          String? corVerso,
          int? quantidadeFolha,
          bool? possuiNumeracao,
          int? numeracaoInicial,
          int? numeracaoFinal,
          String? observacao,
          double? valorCusto,
          double? valorTotal,
          DateTime? createdAt}) =>
      OrdemServicoTableData(
        id: id ?? this.id,
        clienteId: clienteId ?? this.clienteId,
        formatoId: formatoId.present ? formatoId.value : this.formatoId,
        material: material ?? this.material,
        corFrente: corFrente ?? this.corFrente,
        corVerso: corVerso ?? this.corVerso,
        quantidadeFolha: quantidadeFolha ?? this.quantidadeFolha,
        possuiNumeracao: possuiNumeracao ?? this.possuiNumeracao,
        numeracaoInicial: numeracaoInicial ?? this.numeracaoInicial,
        numeracaoFinal: numeracaoFinal ?? this.numeracaoFinal,
        observacao: observacao ?? this.observacao,
        valorCusto: valorCusto ?? this.valorCusto,
        valorTotal: valorTotal ?? this.valorTotal,
        createdAt: createdAt ?? this.createdAt,
      );
  OrdemServicoTableData copyWithCompanion(OrdemServicoTableCompanion data) {
    return OrdemServicoTableData(
      id: data.id.present ? data.id.value : this.id,
      clienteId: data.clienteId.present ? data.clienteId.value : this.clienteId,
      formatoId: data.formatoId.present ? data.formatoId.value : this.formatoId,
      material: data.material.present ? data.material.value : this.material,
      corFrente: data.corFrente.present ? data.corFrente.value : this.corFrente,
      corVerso: data.corVerso.present ? data.corVerso.value : this.corVerso,
      quantidadeFolha: data.quantidadeFolha.present
          ? data.quantidadeFolha.value
          : this.quantidadeFolha,
      possuiNumeracao: data.possuiNumeracao.present
          ? data.possuiNumeracao.value
          : this.possuiNumeracao,
      numeracaoInicial: data.numeracaoInicial.present
          ? data.numeracaoInicial.value
          : this.numeracaoInicial,
      numeracaoFinal: data.numeracaoFinal.present
          ? data.numeracaoFinal.value
          : this.numeracaoFinal,
      observacao:
          data.observacao.present ? data.observacao.value : this.observacao,
      valorCusto:
          data.valorCusto.present ? data.valorCusto.value : this.valorCusto,
      valorTotal:
          data.valorTotal.present ? data.valorTotal.value : this.valorTotal,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrdemServicoTableData(')
          ..write('id: $id, ')
          ..write('clienteId: $clienteId, ')
          ..write('formatoId: $formatoId, ')
          ..write('material: $material, ')
          ..write('corFrente: $corFrente, ')
          ..write('corVerso: $corVerso, ')
          ..write('quantidadeFolha: $quantidadeFolha, ')
          ..write('possuiNumeracao: $possuiNumeracao, ')
          ..write('numeracaoInicial: $numeracaoInicial, ')
          ..write('numeracaoFinal: $numeracaoFinal, ')
          ..write('observacao: $observacao, ')
          ..write('valorCusto: $valorCusto, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      clienteId,
      formatoId,
      material,
      corFrente,
      corVerso,
      quantidadeFolha,
      possuiNumeracao,
      numeracaoInicial,
      numeracaoFinal,
      observacao,
      valorCusto,
      valorTotal,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrdemServicoTableData &&
          other.id == this.id &&
          other.clienteId == this.clienteId &&
          other.formatoId == this.formatoId &&
          other.material == this.material &&
          other.corFrente == this.corFrente &&
          other.corVerso == this.corVerso &&
          other.quantidadeFolha == this.quantidadeFolha &&
          other.possuiNumeracao == this.possuiNumeracao &&
          other.numeracaoInicial == this.numeracaoInicial &&
          other.numeracaoFinal == this.numeracaoFinal &&
          other.observacao == this.observacao &&
          other.valorCusto == this.valorCusto &&
          other.valorTotal == this.valorTotal &&
          other.createdAt == this.createdAt);
}

class OrdemServicoTableCompanion
    extends UpdateCompanion<OrdemServicoTableData> {
  final Value<int> id;
  final Value<String> clienteId;
  final Value<String?> formatoId;
  final Value<String> material;
  final Value<String> corFrente;
  final Value<String> corVerso;
  final Value<int> quantidadeFolha;
  final Value<bool> possuiNumeracao;
  final Value<int> numeracaoInicial;
  final Value<int> numeracaoFinal;
  final Value<String> observacao;
  final Value<double> valorCusto;
  final Value<double> valorTotal;
  final Value<DateTime> createdAt;
  const OrdemServicoTableCompanion({
    this.id = const Value.absent(),
    this.clienteId = const Value.absent(),
    this.formatoId = const Value.absent(),
    this.material = const Value.absent(),
    this.corFrente = const Value.absent(),
    this.corVerso = const Value.absent(),
    this.quantidadeFolha = const Value.absent(),
    this.possuiNumeracao = const Value.absent(),
    this.numeracaoInicial = const Value.absent(),
    this.numeracaoFinal = const Value.absent(),
    this.observacao = const Value.absent(),
    this.valorCusto = const Value.absent(),
    this.valorTotal = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  OrdemServicoTableCompanion.insert({
    this.id = const Value.absent(),
    required String clienteId,
    this.formatoId = const Value.absent(),
    required String material,
    required String corFrente,
    required String corVerso,
    required int quantidadeFolha,
    this.possuiNumeracao = const Value.absent(),
    required int numeracaoInicial,
    required int numeracaoFinal,
    required String observacao,
    this.valorCusto = const Value.absent(),
    this.valorTotal = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : clienteId = Value(clienteId),
        material = Value(material),
        corFrente = Value(corFrente),
        corVerso = Value(corVerso),
        quantidadeFolha = Value(quantidadeFolha),
        numeracaoInicial = Value(numeracaoInicial),
        numeracaoFinal = Value(numeracaoFinal),
        observacao = Value(observacao);
  static Insertable<OrdemServicoTableData> custom({
    Expression<int>? id,
    Expression<String>? clienteId,
    Expression<String>? formatoId,
    Expression<String>? material,
    Expression<String>? corFrente,
    Expression<String>? corVerso,
    Expression<int>? quantidadeFolha,
    Expression<bool>? possuiNumeracao,
    Expression<int>? numeracaoInicial,
    Expression<int>? numeracaoFinal,
    Expression<String>? observacao,
    Expression<double>? valorCusto,
    Expression<double>? valorTotal,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clienteId != null) 'cliente_id': clienteId,
      if (formatoId != null) 'formato_id': formatoId,
      if (material != null) 'material': material,
      if (corFrente != null) 'cor_frente': corFrente,
      if (corVerso != null) 'cor_verso': corVerso,
      if (quantidadeFolha != null) 'quantidade_folha': quantidadeFolha,
      if (possuiNumeracao != null) 'possui_numeracao': possuiNumeracao,
      if (numeracaoInicial != null) 'numeracao_inicial': numeracaoInicial,
      if (numeracaoFinal != null) 'numeracao_final': numeracaoFinal,
      if (observacao != null) 'observacao': observacao,
      if (valorCusto != null) 'valor_custo': valorCusto,
      if (valorTotal != null) 'valor_total': valorTotal,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  OrdemServicoTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? clienteId,
      Value<String?>? formatoId,
      Value<String>? material,
      Value<String>? corFrente,
      Value<String>? corVerso,
      Value<int>? quantidadeFolha,
      Value<bool>? possuiNumeracao,
      Value<int>? numeracaoInicial,
      Value<int>? numeracaoFinal,
      Value<String>? observacao,
      Value<double>? valorCusto,
      Value<double>? valorTotal,
      Value<DateTime>? createdAt}) {
    return OrdemServicoTableCompanion(
      id: id ?? this.id,
      clienteId: clienteId ?? this.clienteId,
      formatoId: formatoId ?? this.formatoId,
      material: material ?? this.material,
      corFrente: corFrente ?? this.corFrente,
      corVerso: corVerso ?? this.corVerso,
      quantidadeFolha: quantidadeFolha ?? this.quantidadeFolha,
      possuiNumeracao: possuiNumeracao ?? this.possuiNumeracao,
      numeracaoInicial: numeracaoInicial ?? this.numeracaoInicial,
      numeracaoFinal: numeracaoFinal ?? this.numeracaoFinal,
      observacao: observacao ?? this.observacao,
      valorCusto: valorCusto ?? this.valorCusto,
      valorTotal: valorTotal ?? this.valorTotal,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clienteId.present) {
      map['cliente_id'] = Variable<String>(clienteId.value);
    }
    if (formatoId.present) {
      map['formato_id'] = Variable<String>(formatoId.value);
    }
    if (material.present) {
      map['material'] = Variable<String>(material.value);
    }
    if (corFrente.present) {
      map['cor_frente'] = Variable<String>(corFrente.value);
    }
    if (corVerso.present) {
      map['cor_verso'] = Variable<String>(corVerso.value);
    }
    if (quantidadeFolha.present) {
      map['quantidade_folha'] = Variable<int>(quantidadeFolha.value);
    }
    if (possuiNumeracao.present) {
      map['possui_numeracao'] = Variable<bool>(possuiNumeracao.value);
    }
    if (numeracaoInicial.present) {
      map['numeracao_inicial'] = Variable<int>(numeracaoInicial.value);
    }
    if (numeracaoFinal.present) {
      map['numeracao_final'] = Variable<int>(numeracaoFinal.value);
    }
    if (observacao.present) {
      map['observacao'] = Variable<String>(observacao.value);
    }
    if (valorCusto.present) {
      map['valor_custo'] = Variable<double>(valorCusto.value);
    }
    if (valorTotal.present) {
      map['valor_total'] = Variable<double>(valorTotal.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(
          $OrdemServicoTableTable.$convertercreatedAt.toSql(createdAt.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdemServicoTableCompanion(')
          ..write('id: $id, ')
          ..write('clienteId: $clienteId, ')
          ..write('formatoId: $formatoId, ')
          ..write('material: $material, ')
          ..write('corFrente: $corFrente, ')
          ..write('corVerso: $corVerso, ')
          ..write('quantidadeFolha: $quantidadeFolha, ')
          ..write('possuiNumeracao: $possuiNumeracao, ')
          ..write('numeracaoInicial: $numeracaoInicial, ')
          ..write('numeracaoFinal: $numeracaoFinal, ')
          ..write('observacao: $observacao, ')
          ..write('valorCusto: $valorCusto, ')
          ..write('valorTotal: $valorTotal, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $FornecedorOrdemServicoTableTable extends FornecedorOrdemServicoTable
    with
        TableInfo<$FornecedorOrdemServicoTableTable,
            FornecedorOrdemServicoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FornecedorOrdemServicoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => Uuid().v4());
  static const VerificationMeta _ordemServicoIdMeta =
      const VerificationMeta('ordemServicoId');
  @override
  late final GeneratedColumn<int> ordemServicoId = GeneratedColumn<int>(
      'ordem_servico_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES ordem_servico_table (id)'));
  static const VerificationMeta _fornecedorIdMeta =
      const VerificationMeta('fornecedorId');
  @override
  late final GeneratedColumn<String> fornecedorId = GeneratedColumn<String>(
      'fornecedor_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES fornecedor_table (id)'));
  static const VerificationMeta _custoMeta = const VerificationMeta('custo');
  @override
  late final GeneratedColumn<double> custo = GeneratedColumn<double>(
      'custo', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, ordemServicoId, fornecedorId, custo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fornecedor_ordem_servico_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<FornecedorOrdemServicoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ordem_servico_id')) {
      context.handle(
          _ordemServicoIdMeta,
          ordemServicoId.isAcceptableOrUnknown(
              data['ordem_servico_id']!, _ordemServicoIdMeta));
    } else if (isInserting) {
      context.missing(_ordemServicoIdMeta);
    }
    if (data.containsKey('fornecedor_id')) {
      context.handle(
          _fornecedorIdMeta,
          fornecedorId.isAcceptableOrUnknown(
              data['fornecedor_id']!, _fornecedorIdMeta));
    } else if (isInserting) {
      context.missing(_fornecedorIdMeta);
    }
    if (data.containsKey('custo')) {
      context.handle(
          _custoMeta, custo.isAcceptableOrUnknown(data['custo']!, _custoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FornecedorOrdemServicoTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FornecedorOrdemServicoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      ordemServicoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ordem_servico_id'])!,
      fornecedorId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fornecedor_id'])!,
      custo: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}custo'])!,
    );
  }

  @override
  $FornecedorOrdemServicoTableTable createAlias(String alias) {
    return $FornecedorOrdemServicoTableTable(attachedDatabase, alias);
  }
}

class FornecedorOrdemServicoTableData extends DataClass
    implements Insertable<FornecedorOrdemServicoTableData> {
  final String id;
  final int ordemServicoId;
  final String fornecedorId;
  final double custo;
  const FornecedorOrdemServicoTableData(
      {required this.id,
      required this.ordemServicoId,
      required this.fornecedorId,
      required this.custo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['ordem_servico_id'] = Variable<int>(ordemServicoId);
    map['fornecedor_id'] = Variable<String>(fornecedorId);
    map['custo'] = Variable<double>(custo);
    return map;
  }

  FornecedorOrdemServicoTableCompanion toCompanion(bool nullToAbsent) {
    return FornecedorOrdemServicoTableCompanion(
      id: Value(id),
      ordemServicoId: Value(ordemServicoId),
      fornecedorId: Value(fornecedorId),
      custo: Value(custo),
    );
  }

  factory FornecedorOrdemServicoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FornecedorOrdemServicoTableData(
      id: serializer.fromJson<String>(json['id']),
      ordemServicoId: serializer.fromJson<int>(json['ordemServicoId']),
      fornecedorId: serializer.fromJson<String>(json['fornecedorId']),
      custo: serializer.fromJson<double>(json['custo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ordemServicoId': serializer.toJson<int>(ordemServicoId),
      'fornecedorId': serializer.toJson<String>(fornecedorId),
      'custo': serializer.toJson<double>(custo),
    };
  }

  FornecedorOrdemServicoTableData copyWith(
          {String? id,
          int? ordemServicoId,
          String? fornecedorId,
          double? custo}) =>
      FornecedorOrdemServicoTableData(
        id: id ?? this.id,
        ordemServicoId: ordemServicoId ?? this.ordemServicoId,
        fornecedorId: fornecedorId ?? this.fornecedorId,
        custo: custo ?? this.custo,
      );
  FornecedorOrdemServicoTableData copyWithCompanion(
      FornecedorOrdemServicoTableCompanion data) {
    return FornecedorOrdemServicoTableData(
      id: data.id.present ? data.id.value : this.id,
      ordemServicoId: data.ordemServicoId.present
          ? data.ordemServicoId.value
          : this.ordemServicoId,
      fornecedorId: data.fornecedorId.present
          ? data.fornecedorId.value
          : this.fornecedorId,
      custo: data.custo.present ? data.custo.value : this.custo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FornecedorOrdemServicoTableData(')
          ..write('id: $id, ')
          ..write('ordemServicoId: $ordemServicoId, ')
          ..write('fornecedorId: $fornecedorId, ')
          ..write('custo: $custo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ordemServicoId, fornecedorId, custo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FornecedorOrdemServicoTableData &&
          other.id == this.id &&
          other.ordemServicoId == this.ordemServicoId &&
          other.fornecedorId == this.fornecedorId &&
          other.custo == this.custo);
}

class FornecedorOrdemServicoTableCompanion
    extends UpdateCompanion<FornecedorOrdemServicoTableData> {
  final Value<String> id;
  final Value<int> ordemServicoId;
  final Value<String> fornecedorId;
  final Value<double> custo;
  final Value<int> rowid;
  const FornecedorOrdemServicoTableCompanion({
    this.id = const Value.absent(),
    this.ordemServicoId = const Value.absent(),
    this.fornecedorId = const Value.absent(),
    this.custo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FornecedorOrdemServicoTableCompanion.insert({
    this.id = const Value.absent(),
    required int ordemServicoId,
    required String fornecedorId,
    this.custo = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : ordemServicoId = Value(ordemServicoId),
        fornecedorId = Value(fornecedorId);
  static Insertable<FornecedorOrdemServicoTableData> custom({
    Expression<String>? id,
    Expression<int>? ordemServicoId,
    Expression<String>? fornecedorId,
    Expression<double>? custo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ordemServicoId != null) 'ordem_servico_id': ordemServicoId,
      if (fornecedorId != null) 'fornecedor_id': fornecedorId,
      if (custo != null) 'custo': custo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FornecedorOrdemServicoTableCompanion copyWith(
      {Value<String>? id,
      Value<int>? ordemServicoId,
      Value<String>? fornecedorId,
      Value<double>? custo,
      Value<int>? rowid}) {
    return FornecedorOrdemServicoTableCompanion(
      id: id ?? this.id,
      ordemServicoId: ordemServicoId ?? this.ordemServicoId,
      fornecedorId: fornecedorId ?? this.fornecedorId,
      custo: custo ?? this.custo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ordemServicoId.present) {
      map['ordem_servico_id'] = Variable<int>(ordemServicoId.value);
    }
    if (fornecedorId.present) {
      map['fornecedor_id'] = Variable<String>(fornecedorId.value);
    }
    if (custo.present) {
      map['custo'] = Variable<double>(custo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FornecedorOrdemServicoTableCompanion(')
          ..write('id: $id, ')
          ..write('ordemServicoId: $ordemServicoId, ')
          ..write('fornecedorId: $fornecedorId, ')
          ..write('custo: $custo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FornecedorTableTable fornecedorTable =
      $FornecedorTableTable(this);
  late final $FormatoTableTable formatoTable = $FormatoTableTable(this);
  late final $ViaCoresTableTable viaCoresTable = $ViaCoresTableTable(this);
  late final $PapelTableTable papelTable = $PapelTableTable(this);
  late final $UfTableTable ufTable = $UfTableTable(this);
  late final $ClientesTableTable clientesTable = $ClientesTableTable(this);
  late final $OrdemServicoTableTable ordemServicoTable =
      $OrdemServicoTableTable(this);
  late final $FornecedorOrdemServicoTableTable fornecedorOrdemServicoTable =
      $FornecedorOrdemServicoTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        fornecedorTable,
        formatoTable,
        viaCoresTable,
        papelTable,
        ufTable,
        clientesTable,
        ordemServicoTable,
        fornecedorOrdemServicoTable
      ];
}

typedef $$FornecedorTableTableCreateCompanionBuilder = FornecedorTableCompanion
    Function({
  Value<String> id,
  required String nome,
  required String contato,
  required String telefone,
  required String email,
  required String observacao,
  required TipoServico tipoServico,
  Value<int> rowid,
});
typedef $$FornecedorTableTableUpdateCompanionBuilder = FornecedorTableCompanion
    Function({
  Value<String> id,
  Value<String> nome,
  Value<String> contato,
  Value<String> telefone,
  Value<String> email,
  Value<String> observacao,
  Value<TipoServico> tipoServico,
  Value<int> rowid,
});

final class $$FornecedorTableTableReferences extends BaseReferences<
    _$AppDatabase, $FornecedorTableTable, FornecedorTableData> {
  $$FornecedorTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FornecedorOrdemServicoTableTable,
          List<FornecedorOrdemServicoTableData>>
      _fornecedorOrdemServicoTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.fornecedorOrdemServicoTable,
              aliasName: $_aliasNameGenerator(db.fornecedorTable.id,
                  db.fornecedorOrdemServicoTable.fornecedorId));

  $$FornecedorOrdemServicoTableTableProcessedTableManager
      get fornecedorOrdemServicoTableRefs {
    final manager = $$FornecedorOrdemServicoTableTableTableManager(
            $_db, $_db.fornecedorOrdemServicoTable)
        .filter(
            (f) => f.fornecedorId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult
        .readTableOrNull(_fornecedorOrdemServicoTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FornecedorTableTableFilterComposer
    extends Composer<_$AppDatabase, $FornecedorTableTable> {
  $$FornecedorTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contato => $composableBuilder(
      column: $table.contato, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TipoServico, TipoServico, String>
      get tipoServico => $composableBuilder(
          column: $table.tipoServico,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  Expression<bool> fornecedorOrdemServicoTableRefs(
      Expression<bool> Function(
              $$FornecedorOrdemServicoTableTableFilterComposer f)
          f) {
    final $$FornecedorOrdemServicoTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.fornecedorOrdemServicoTable,
            getReferencedColumn: (t) => t.fornecedorId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$FornecedorOrdemServicoTableTableFilterComposer(
                  $db: $db,
                  $table: $db.fornecedorOrdemServicoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$FornecedorTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FornecedorTableTable> {
  $$FornecedorTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contato => $composableBuilder(
      column: $table.contato, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipoServico => $composableBuilder(
      column: $table.tipoServico, builder: (column) => ColumnOrderings(column));
}

class $$FornecedorTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FornecedorTableTable> {
  $$FornecedorTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get contato =>
      $composableBuilder(column: $table.contato, builder: (column) => column);

  GeneratedColumn<String> get telefone =>
      $composableBuilder(column: $table.telefone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipoServico, String> get tipoServico =>
      $composableBuilder(
          column: $table.tipoServico, builder: (column) => column);

  Expression<T> fornecedorOrdemServicoTableRefs<T extends Object>(
      Expression<T> Function(
              $$FornecedorOrdemServicoTableTableAnnotationComposer a)
          f) {
    final $$FornecedorOrdemServicoTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.fornecedorOrdemServicoTable,
            getReferencedColumn: (t) => t.fornecedorId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$FornecedorOrdemServicoTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.fornecedorOrdemServicoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$FornecedorTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FornecedorTableTable,
    FornecedorTableData,
    $$FornecedorTableTableFilterComposer,
    $$FornecedorTableTableOrderingComposer,
    $$FornecedorTableTableAnnotationComposer,
    $$FornecedorTableTableCreateCompanionBuilder,
    $$FornecedorTableTableUpdateCompanionBuilder,
    (FornecedorTableData, $$FornecedorTableTableReferences),
    FornecedorTableData,
    PrefetchHooks Function({bool fornecedorOrdemServicoTableRefs})> {
  $$FornecedorTableTableTableManager(
      _$AppDatabase db, $FornecedorTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FornecedorTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FornecedorTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FornecedorTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String> contato = const Value.absent(),
            Value<String> telefone = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> observacao = const Value.absent(),
            Value<TipoServico> tipoServico = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FornecedorTableCompanion(
            id: id,
            nome: nome,
            contato: contato,
            telefone: telefone,
            email: email,
            observacao: observacao,
            tipoServico: tipoServico,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String nome,
            required String contato,
            required String telefone,
            required String email,
            required String observacao,
            required TipoServico tipoServico,
            Value<int> rowid = const Value.absent(),
          }) =>
              FornecedorTableCompanion.insert(
            id: id,
            nome: nome,
            contato: contato,
            telefone: telefone,
            email: email,
            observacao: observacao,
            tipoServico: tipoServico,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FornecedorTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({fornecedorOrdemServicoTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (fornecedorOrdemServicoTableRefs)
                  db.fornecedorOrdemServicoTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (fornecedorOrdemServicoTableRefs)
                    await $_getPrefetchedData<
                            FornecedorTableData,
                            $FornecedorTableTable,
                            FornecedorOrdemServicoTableData>(
                        currentTable: table,
                        referencedTable: $$FornecedorTableTableReferences
                            ._fornecedorOrdemServicoTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FornecedorTableTableReferences(db, table, p0)
                                .fornecedorOrdemServicoTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.fornecedorId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FornecedorTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FornecedorTableTable,
    FornecedorTableData,
    $$FornecedorTableTableFilterComposer,
    $$FornecedorTableTableOrderingComposer,
    $$FornecedorTableTableAnnotationComposer,
    $$FornecedorTableTableCreateCompanionBuilder,
    $$FornecedorTableTableUpdateCompanionBuilder,
    (FornecedorTableData, $$FornecedorTableTableReferences),
    FornecedorTableData,
    PrefetchHooks Function({bool fornecedorOrdemServicoTableRefs})>;
typedef $$FormatoTableTableCreateCompanionBuilder = FormatoTableCompanion
    Function({
  Value<String> id,
  required String descricao,
  Value<int> rowid,
});
typedef $$FormatoTableTableUpdateCompanionBuilder = FormatoTableCompanion
    Function({
  Value<String> id,
  Value<String> descricao,
  Value<int> rowid,
});

final class $$FormatoTableTableReferences extends BaseReferences<_$AppDatabase,
    $FormatoTableTable, FormatoTableData> {
  $$FormatoTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$OrdemServicoTableTable,
      List<OrdemServicoTableData>> _ordemServicoTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.ordemServicoTable,
          aliasName: $_aliasNameGenerator(
              db.formatoTable.id, db.ordemServicoTable.formatoId));

  $$OrdemServicoTableTableProcessedTableManager get ordemServicoTableRefs {
    final manager = $$OrdemServicoTableTableTableManager(
            $_db, $_db.ordemServicoTable)
        .filter((f) => f.formatoId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_ordemServicoTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FormatoTableTableFilterComposer
    extends Composer<_$AppDatabase, $FormatoTableTable> {
  $$FormatoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnFilters(column));

  Expression<bool> ordemServicoTableRefs(
      Expression<bool> Function($$OrdemServicoTableTableFilterComposer f) f) {
    final $$OrdemServicoTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ordemServicoTable,
        getReferencedColumn: (t) => t.formatoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdemServicoTableTableFilterComposer(
              $db: $db,
              $table: $db.ordemServicoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FormatoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FormatoTableTable> {
  $$FormatoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnOrderings(column));
}

class $$FormatoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FormatoTableTable> {
  $$FormatoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get descricao =>
      $composableBuilder(column: $table.descricao, builder: (column) => column);

  Expression<T> ordemServicoTableRefs<T extends Object>(
      Expression<T> Function($$OrdemServicoTableTableAnnotationComposer a) f) {
    final $$OrdemServicoTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.ordemServicoTable,
            getReferencedColumn: (t) => t.formatoId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$OrdemServicoTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.ordemServicoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$FormatoTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FormatoTableTable,
    FormatoTableData,
    $$FormatoTableTableFilterComposer,
    $$FormatoTableTableOrderingComposer,
    $$FormatoTableTableAnnotationComposer,
    $$FormatoTableTableCreateCompanionBuilder,
    $$FormatoTableTableUpdateCompanionBuilder,
    (FormatoTableData, $$FormatoTableTableReferences),
    FormatoTableData,
    PrefetchHooks Function({bool ordemServicoTableRefs})> {
  $$FormatoTableTableTableManager(_$AppDatabase db, $FormatoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FormatoTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FormatoTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FormatoTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> descricao = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FormatoTableCompanion(
            id: id,
            descricao: descricao,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String descricao,
            Value<int> rowid = const Value.absent(),
          }) =>
              FormatoTableCompanion.insert(
            id: id,
            descricao: descricao,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FormatoTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({ordemServicoTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (ordemServicoTableRefs) db.ordemServicoTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ordemServicoTableRefs)
                    await $_getPrefetchedData<FormatoTableData,
                            $FormatoTableTable, OrdemServicoTableData>(
                        currentTable: table,
                        referencedTable: $$FormatoTableTableReferences
                            ._ordemServicoTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FormatoTableTableReferences(db, table, p0)
                                .ordemServicoTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.formatoId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FormatoTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FormatoTableTable,
    FormatoTableData,
    $$FormatoTableTableFilterComposer,
    $$FormatoTableTableOrderingComposer,
    $$FormatoTableTableAnnotationComposer,
    $$FormatoTableTableCreateCompanionBuilder,
    $$FormatoTableTableUpdateCompanionBuilder,
    (FormatoTableData, $$FormatoTableTableReferences),
    FormatoTableData,
    PrefetchHooks Function({bool ordemServicoTableRefs})>;
typedef $$ViaCoresTableTableCreateCompanionBuilder = ViaCoresTableCompanion
    Function({
  Value<String> id,
  required String descricao,
  Value<int> rowid,
});
typedef $$ViaCoresTableTableUpdateCompanionBuilder = ViaCoresTableCompanion
    Function({
  Value<String> id,
  Value<String> descricao,
  Value<int> rowid,
});

class $$ViaCoresTableTableFilterComposer
    extends Composer<_$AppDatabase, $ViaCoresTableTable> {
  $$ViaCoresTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnFilters(column));
}

class $$ViaCoresTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ViaCoresTableTable> {
  $$ViaCoresTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnOrderings(column));
}

class $$ViaCoresTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ViaCoresTableTable> {
  $$ViaCoresTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get descricao =>
      $composableBuilder(column: $table.descricao, builder: (column) => column);
}

class $$ViaCoresTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ViaCoresTableTable,
    ViaCoresTableData,
    $$ViaCoresTableTableFilterComposer,
    $$ViaCoresTableTableOrderingComposer,
    $$ViaCoresTableTableAnnotationComposer,
    $$ViaCoresTableTableCreateCompanionBuilder,
    $$ViaCoresTableTableUpdateCompanionBuilder,
    (
      ViaCoresTableData,
      BaseReferences<_$AppDatabase, $ViaCoresTableTable, ViaCoresTableData>
    ),
    ViaCoresTableData,
    PrefetchHooks Function()> {
  $$ViaCoresTableTableTableManager(_$AppDatabase db, $ViaCoresTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ViaCoresTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ViaCoresTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ViaCoresTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> descricao = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ViaCoresTableCompanion(
            id: id,
            descricao: descricao,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String descricao,
            Value<int> rowid = const Value.absent(),
          }) =>
              ViaCoresTableCompanion.insert(
            id: id,
            descricao: descricao,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ViaCoresTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ViaCoresTableTable,
    ViaCoresTableData,
    $$ViaCoresTableTableFilterComposer,
    $$ViaCoresTableTableOrderingComposer,
    $$ViaCoresTableTableAnnotationComposer,
    $$ViaCoresTableTableCreateCompanionBuilder,
    $$ViaCoresTableTableUpdateCompanionBuilder,
    (
      ViaCoresTableData,
      BaseReferences<_$AppDatabase, $ViaCoresTableTable, ViaCoresTableData>
    ),
    ViaCoresTableData,
    PrefetchHooks Function()>;
typedef $$PapelTableTableCreateCompanionBuilder = PapelTableCompanion Function({
  Value<String> id,
  required String descricao,
  required int quantidadePapel,
  Value<int> rowid,
});
typedef $$PapelTableTableUpdateCompanionBuilder = PapelTableCompanion Function({
  Value<String> id,
  Value<String> descricao,
  Value<int> quantidadePapel,
  Value<int> rowid,
});

class $$PapelTableTableFilterComposer
    extends Composer<_$AppDatabase, $PapelTableTable> {
  $$PapelTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantidadePapel => $composableBuilder(
      column: $table.quantidadePapel,
      builder: (column) => ColumnFilters(column));
}

class $$PapelTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PapelTableTable> {
  $$PapelTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantidadePapel => $composableBuilder(
      column: $table.quantidadePapel,
      builder: (column) => ColumnOrderings(column));
}

class $$PapelTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PapelTableTable> {
  $$PapelTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get descricao =>
      $composableBuilder(column: $table.descricao, builder: (column) => column);

  GeneratedColumn<int> get quantidadePapel => $composableBuilder(
      column: $table.quantidadePapel, builder: (column) => column);
}

class $$PapelTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PapelTableTable,
    PapelTableData,
    $$PapelTableTableFilterComposer,
    $$PapelTableTableOrderingComposer,
    $$PapelTableTableAnnotationComposer,
    $$PapelTableTableCreateCompanionBuilder,
    $$PapelTableTableUpdateCompanionBuilder,
    (
      PapelTableData,
      BaseReferences<_$AppDatabase, $PapelTableTable, PapelTableData>
    ),
    PapelTableData,
    PrefetchHooks Function()> {
  $$PapelTableTableTableManager(_$AppDatabase db, $PapelTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PapelTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PapelTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PapelTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> descricao = const Value.absent(),
            Value<int> quantidadePapel = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PapelTableCompanion(
            id: id,
            descricao: descricao,
            quantidadePapel: quantidadePapel,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String descricao,
            required int quantidadePapel,
            Value<int> rowid = const Value.absent(),
          }) =>
              PapelTableCompanion.insert(
            id: id,
            descricao: descricao,
            quantidadePapel: quantidadePapel,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PapelTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PapelTableTable,
    PapelTableData,
    $$PapelTableTableFilterComposer,
    $$PapelTableTableOrderingComposer,
    $$PapelTableTableAnnotationComposer,
    $$PapelTableTableCreateCompanionBuilder,
    $$PapelTableTableUpdateCompanionBuilder,
    (
      PapelTableData,
      BaseReferences<_$AppDatabase, $PapelTableTable, PapelTableData>
    ),
    PapelTableData,
    PrefetchHooks Function()>;
typedef $$UfTableTableCreateCompanionBuilder = UfTableCompanion Function({
  Value<String> id,
  required String descricao,
  required String sigla,
  Value<int> rowid,
});
typedef $$UfTableTableUpdateCompanionBuilder = UfTableCompanion Function({
  Value<String> id,
  Value<String> descricao,
  Value<String> sigla,
  Value<int> rowid,
});

class $$UfTableTableFilterComposer
    extends Composer<_$AppDatabase, $UfTableTable> {
  $$UfTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sigla => $composableBuilder(
      column: $table.sigla, builder: (column) => ColumnFilters(column));
}

class $$UfTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UfTableTable> {
  $$UfTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descricao => $composableBuilder(
      column: $table.descricao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sigla => $composableBuilder(
      column: $table.sigla, builder: (column) => ColumnOrderings(column));
}

class $$UfTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UfTableTable> {
  $$UfTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get descricao =>
      $composableBuilder(column: $table.descricao, builder: (column) => column);

  GeneratedColumn<String> get sigla =>
      $composableBuilder(column: $table.sigla, builder: (column) => column);
}

class $$UfTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UfTableTable,
    UfTableData,
    $$UfTableTableFilterComposer,
    $$UfTableTableOrderingComposer,
    $$UfTableTableAnnotationComposer,
    $$UfTableTableCreateCompanionBuilder,
    $$UfTableTableUpdateCompanionBuilder,
    (UfTableData, BaseReferences<_$AppDatabase, $UfTableTable, UfTableData>),
    UfTableData,
    PrefetchHooks Function()> {
  $$UfTableTableTableManager(_$AppDatabase db, $UfTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UfTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UfTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UfTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> descricao = const Value.absent(),
            Value<String> sigla = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UfTableCompanion(
            id: id,
            descricao: descricao,
            sigla: sigla,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String descricao,
            required String sigla,
            Value<int> rowid = const Value.absent(),
          }) =>
              UfTableCompanion.insert(
            id: id,
            descricao: descricao,
            sigla: sigla,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UfTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UfTableTable,
    UfTableData,
    $$UfTableTableFilterComposer,
    $$UfTableTableOrderingComposer,
    $$UfTableTableAnnotationComposer,
    $$UfTableTableCreateCompanionBuilder,
    $$UfTableTableUpdateCompanionBuilder,
    (UfTableData, BaseReferences<_$AppDatabase, $UfTableTable, UfTableData>),
    UfTableData,
    PrefetchHooks Function()>;
typedef $$ClientesTableTableCreateCompanionBuilder = ClientesTableCompanion
    Function({
  Value<String> id,
  required String nomeEmpresa,
  required String documento,
  Value<String?> email,
  Value<String?> contato,
  Value<String?> telefone,
  Value<int> rowid,
});
typedef $$ClientesTableTableUpdateCompanionBuilder = ClientesTableCompanion
    Function({
  Value<String> id,
  Value<String> nomeEmpresa,
  Value<String> documento,
  Value<String?> email,
  Value<String?> contato,
  Value<String?> telefone,
  Value<int> rowid,
});

final class $$ClientesTableTableReferences extends BaseReferences<_$AppDatabase,
    $ClientesTableTable, ClientesTableData> {
  $$ClientesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$OrdemServicoTableTable,
      List<OrdemServicoTableData>> _ordemServicoTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.ordemServicoTable,
          aliasName: $_aliasNameGenerator(
              db.clientesTable.id, db.ordemServicoTable.clienteId));

  $$OrdemServicoTableTableProcessedTableManager get ordemServicoTableRefs {
    final manager = $$OrdemServicoTableTableTableManager(
            $_db, $_db.ordemServicoTable)
        .filter((f) => f.clienteId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_ordemServicoTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ClientesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ClientesTableTable> {
  $$ClientesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nomeEmpresa => $composableBuilder(
      column: $table.nomeEmpresa, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get documento => $composableBuilder(
      column: $table.documento, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contato => $composableBuilder(
      column: $table.contato, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnFilters(column));

  Expression<bool> ordemServicoTableRefs(
      Expression<bool> Function($$OrdemServicoTableTableFilterComposer f) f) {
    final $$OrdemServicoTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ordemServicoTable,
        getReferencedColumn: (t) => t.clienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdemServicoTableTableFilterComposer(
              $db: $db,
              $table: $db.ordemServicoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ClientesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientesTableTable> {
  $$ClientesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nomeEmpresa => $composableBuilder(
      column: $table.nomeEmpresa, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get documento => $composableBuilder(
      column: $table.documento, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contato => $composableBuilder(
      column: $table.contato, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefone => $composableBuilder(
      column: $table.telefone, builder: (column) => ColumnOrderings(column));
}

class $$ClientesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientesTableTable> {
  $$ClientesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nomeEmpresa => $composableBuilder(
      column: $table.nomeEmpresa, builder: (column) => column);

  GeneratedColumn<String> get documento =>
      $composableBuilder(column: $table.documento, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get contato =>
      $composableBuilder(column: $table.contato, builder: (column) => column);

  GeneratedColumn<String> get telefone =>
      $composableBuilder(column: $table.telefone, builder: (column) => column);

  Expression<T> ordemServicoTableRefs<T extends Object>(
      Expression<T> Function($$OrdemServicoTableTableAnnotationComposer a) f) {
    final $$OrdemServicoTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.ordemServicoTable,
            getReferencedColumn: (t) => t.clienteId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$OrdemServicoTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.ordemServicoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ClientesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClientesTableTable,
    ClientesTableData,
    $$ClientesTableTableFilterComposer,
    $$ClientesTableTableOrderingComposer,
    $$ClientesTableTableAnnotationComposer,
    $$ClientesTableTableCreateCompanionBuilder,
    $$ClientesTableTableUpdateCompanionBuilder,
    (ClientesTableData, $$ClientesTableTableReferences),
    ClientesTableData,
    PrefetchHooks Function({bool ordemServicoTableRefs})> {
  $$ClientesTableTableTableManager(_$AppDatabase db, $ClientesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nomeEmpresa = const Value.absent(),
            Value<String> documento = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> contato = const Value.absent(),
            Value<String?> telefone = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientesTableCompanion(
            id: id,
            nomeEmpresa: nomeEmpresa,
            documento: documento,
            email: email,
            contato: contato,
            telefone: telefone,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String nomeEmpresa,
            required String documento,
            Value<String?> email = const Value.absent(),
            Value<String?> contato = const Value.absent(),
            Value<String?> telefone = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientesTableCompanion.insert(
            id: id,
            nomeEmpresa: nomeEmpresa,
            documento: documento,
            email: email,
            contato: contato,
            telefone: telefone,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ClientesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({ordemServicoTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (ordemServicoTableRefs) db.ordemServicoTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ordemServicoTableRefs)
                    await $_getPrefetchedData<ClientesTableData,
                            $ClientesTableTable, OrdemServicoTableData>(
                        currentTable: table,
                        referencedTable: $$ClientesTableTableReferences
                            ._ordemServicoTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClientesTableTableReferences(db, table, p0)
                                .ordemServicoTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.clienteId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ClientesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClientesTableTable,
    ClientesTableData,
    $$ClientesTableTableFilterComposer,
    $$ClientesTableTableOrderingComposer,
    $$ClientesTableTableAnnotationComposer,
    $$ClientesTableTableCreateCompanionBuilder,
    $$ClientesTableTableUpdateCompanionBuilder,
    (ClientesTableData, $$ClientesTableTableReferences),
    ClientesTableData,
    PrefetchHooks Function({bool ordemServicoTableRefs})>;
typedef $$OrdemServicoTableTableCreateCompanionBuilder
    = OrdemServicoTableCompanion Function({
  Value<int> id,
  required String clienteId,
  Value<String?> formatoId,
  required String material,
  required String corFrente,
  required String corVerso,
  required int quantidadeFolha,
  Value<bool> possuiNumeracao,
  required int numeracaoInicial,
  required int numeracaoFinal,
  required String observacao,
  Value<double> valorCusto,
  Value<double> valorTotal,
  Value<DateTime> createdAt,
});
typedef $$OrdemServicoTableTableUpdateCompanionBuilder
    = OrdemServicoTableCompanion Function({
  Value<int> id,
  Value<String> clienteId,
  Value<String?> formatoId,
  Value<String> material,
  Value<String> corFrente,
  Value<String> corVerso,
  Value<int> quantidadeFolha,
  Value<bool> possuiNumeracao,
  Value<int> numeracaoInicial,
  Value<int> numeracaoFinal,
  Value<String> observacao,
  Value<double> valorCusto,
  Value<double> valorTotal,
  Value<DateTime> createdAt,
});

final class $$OrdemServicoTableTableReferences extends BaseReferences<
    _$AppDatabase, $OrdemServicoTableTable, OrdemServicoTableData> {
  $$OrdemServicoTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ClientesTableTable _clienteIdTable(_$AppDatabase db) =>
      db.clientesTable.createAlias($_aliasNameGenerator(
          db.ordemServicoTable.clienteId, db.clientesTable.id));

  $$ClientesTableTableProcessedTableManager get clienteId {
    final $_column = $_itemColumn<String>('cliente_id')!;

    final manager = $$ClientesTableTableTableManager($_db, $_db.clientesTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clienteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $FormatoTableTable _formatoIdTable(_$AppDatabase db) =>
      db.formatoTable.createAlias($_aliasNameGenerator(
          db.ordemServicoTable.formatoId, db.formatoTable.id));

  $$FormatoTableTableProcessedTableManager? get formatoId {
    final $_column = $_itemColumn<String>('formato_id');
    if ($_column == null) return null;
    final manager = $$FormatoTableTableTableManager($_db, $_db.formatoTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_formatoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$FornecedorOrdemServicoTableTable,
          List<FornecedorOrdemServicoTableData>>
      _fornecedorOrdemServicoTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.fornecedorOrdemServicoTable,
              aliasName: $_aliasNameGenerator(db.ordemServicoTable.id,
                  db.fornecedorOrdemServicoTable.ordemServicoId));

  $$FornecedorOrdemServicoTableTableProcessedTableManager
      get fornecedorOrdemServicoTableRefs {
    final manager = $$FornecedorOrdemServicoTableTableTableManager(
            $_db, $_db.fornecedorOrdemServicoTable)
        .filter((f) => f.ordemServicoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult
        .readTableOrNull(_fornecedorOrdemServicoTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$OrdemServicoTableTableFilterComposer
    extends Composer<_$AppDatabase, $OrdemServicoTableTable> {
  $$OrdemServicoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get material => $composableBuilder(
      column: $table.material, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get corFrente => $composableBuilder(
      column: $table.corFrente, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get corVerso => $composableBuilder(
      column: $table.corVerso, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantidadeFolha => $composableBuilder(
      column: $table.quantidadeFolha,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get possuiNumeracao => $composableBuilder(
      column: $table.possuiNumeracao,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get numeracaoInicial => $composableBuilder(
      column: $table.numeracaoInicial,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get numeracaoFinal => $composableBuilder(
      column: $table.numeracaoFinal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get valorCusto => $composableBuilder(
      column: $table.valorCusto, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get valorTotal => $composableBuilder(
      column: $table.valorTotal, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<DateTime, DateTime, String> get createdAt =>
      $composableBuilder(
          column: $table.createdAt,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  $$ClientesTableTableFilterComposer get clienteId {
    final $$ClientesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clienteId,
        referencedTable: $db.clientesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientesTableTableFilterComposer(
              $db: $db,
              $table: $db.clientesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FormatoTableTableFilterComposer get formatoId {
    final $$FormatoTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.formatoId,
        referencedTable: $db.formatoTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FormatoTableTableFilterComposer(
              $db: $db,
              $table: $db.formatoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> fornecedorOrdemServicoTableRefs(
      Expression<bool> Function(
              $$FornecedorOrdemServicoTableTableFilterComposer f)
          f) {
    final $$FornecedorOrdemServicoTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.fornecedorOrdemServicoTable,
            getReferencedColumn: (t) => t.ordemServicoId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$FornecedorOrdemServicoTableTableFilterComposer(
                  $db: $db,
                  $table: $db.fornecedorOrdemServicoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$OrdemServicoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdemServicoTableTable> {
  $$OrdemServicoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get material => $composableBuilder(
      column: $table.material, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get corFrente => $composableBuilder(
      column: $table.corFrente, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get corVerso => $composableBuilder(
      column: $table.corVerso, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantidadeFolha => $composableBuilder(
      column: $table.quantidadeFolha,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get possuiNumeracao => $composableBuilder(
      column: $table.possuiNumeracao,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get numeracaoInicial => $composableBuilder(
      column: $table.numeracaoInicial,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get numeracaoFinal => $composableBuilder(
      column: $table.numeracaoFinal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get valorCusto => $composableBuilder(
      column: $table.valorCusto, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get valorTotal => $composableBuilder(
      column: $table.valorTotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ClientesTableTableOrderingComposer get clienteId {
    final $$ClientesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clienteId,
        referencedTable: $db.clientesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientesTableTableOrderingComposer(
              $db: $db,
              $table: $db.clientesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FormatoTableTableOrderingComposer get formatoId {
    final $$FormatoTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.formatoId,
        referencedTable: $db.formatoTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FormatoTableTableOrderingComposer(
              $db: $db,
              $table: $db.formatoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$OrdemServicoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdemServicoTableTable> {
  $$OrdemServicoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get material =>
      $composableBuilder(column: $table.material, builder: (column) => column);

  GeneratedColumn<String> get corFrente =>
      $composableBuilder(column: $table.corFrente, builder: (column) => column);

  GeneratedColumn<String> get corVerso =>
      $composableBuilder(column: $table.corVerso, builder: (column) => column);

  GeneratedColumn<int> get quantidadeFolha => $composableBuilder(
      column: $table.quantidadeFolha, builder: (column) => column);

  GeneratedColumn<bool> get possuiNumeracao => $composableBuilder(
      column: $table.possuiNumeracao, builder: (column) => column);

  GeneratedColumn<int> get numeracaoInicial => $composableBuilder(
      column: $table.numeracaoInicial, builder: (column) => column);

  GeneratedColumn<int> get numeracaoFinal => $composableBuilder(
      column: $table.numeracaoFinal, builder: (column) => column);

  GeneratedColumn<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => column);

  GeneratedColumn<double> get valorCusto => $composableBuilder(
      column: $table.valorCusto, builder: (column) => column);

  GeneratedColumn<double> get valorTotal => $composableBuilder(
      column: $table.valorTotal, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DateTime, String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ClientesTableTableAnnotationComposer get clienteId {
    final $$ClientesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clienteId,
        referencedTable: $db.clientesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.clientesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FormatoTableTableAnnotationComposer get formatoId {
    final $$FormatoTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.formatoId,
        referencedTable: $db.formatoTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FormatoTableTableAnnotationComposer(
              $db: $db,
              $table: $db.formatoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> fornecedorOrdemServicoTableRefs<T extends Object>(
      Expression<T> Function(
              $$FornecedorOrdemServicoTableTableAnnotationComposer a)
          f) {
    final $$FornecedorOrdemServicoTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.fornecedorOrdemServicoTable,
            getReferencedColumn: (t) => t.ordemServicoId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$FornecedorOrdemServicoTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.fornecedorOrdemServicoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$OrdemServicoTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrdemServicoTableTable,
    OrdemServicoTableData,
    $$OrdemServicoTableTableFilterComposer,
    $$OrdemServicoTableTableOrderingComposer,
    $$OrdemServicoTableTableAnnotationComposer,
    $$OrdemServicoTableTableCreateCompanionBuilder,
    $$OrdemServicoTableTableUpdateCompanionBuilder,
    (OrdemServicoTableData, $$OrdemServicoTableTableReferences),
    OrdemServicoTableData,
    PrefetchHooks Function(
        {bool clienteId,
        bool formatoId,
        bool fornecedorOrdemServicoTableRefs})> {
  $$OrdemServicoTableTableTableManager(
      _$AppDatabase db, $OrdemServicoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdemServicoTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdemServicoTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdemServicoTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> clienteId = const Value.absent(),
            Value<String?> formatoId = const Value.absent(),
            Value<String> material = const Value.absent(),
            Value<String> corFrente = const Value.absent(),
            Value<String> corVerso = const Value.absent(),
            Value<int> quantidadeFolha = const Value.absent(),
            Value<bool> possuiNumeracao = const Value.absent(),
            Value<int> numeracaoInicial = const Value.absent(),
            Value<int> numeracaoFinal = const Value.absent(),
            Value<String> observacao = const Value.absent(),
            Value<double> valorCusto = const Value.absent(),
            Value<double> valorTotal = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              OrdemServicoTableCompanion(
            id: id,
            clienteId: clienteId,
            formatoId: formatoId,
            material: material,
            corFrente: corFrente,
            corVerso: corVerso,
            quantidadeFolha: quantidadeFolha,
            possuiNumeracao: possuiNumeracao,
            numeracaoInicial: numeracaoInicial,
            numeracaoFinal: numeracaoFinal,
            observacao: observacao,
            valorCusto: valorCusto,
            valorTotal: valorTotal,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String clienteId,
            Value<String?> formatoId = const Value.absent(),
            required String material,
            required String corFrente,
            required String corVerso,
            required int quantidadeFolha,
            Value<bool> possuiNumeracao = const Value.absent(),
            required int numeracaoInicial,
            required int numeracaoFinal,
            required String observacao,
            Value<double> valorCusto = const Value.absent(),
            Value<double> valorTotal = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              OrdemServicoTableCompanion.insert(
            id: id,
            clienteId: clienteId,
            formatoId: formatoId,
            material: material,
            corFrente: corFrente,
            corVerso: corVerso,
            quantidadeFolha: quantidadeFolha,
            possuiNumeracao: possuiNumeracao,
            numeracaoInicial: numeracaoInicial,
            numeracaoFinal: numeracaoFinal,
            observacao: observacao,
            valorCusto: valorCusto,
            valorTotal: valorTotal,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$OrdemServicoTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {clienteId = false,
              formatoId = false,
              fornecedorOrdemServicoTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (fornecedorOrdemServicoTableRefs)
                  db.fornecedorOrdemServicoTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (clienteId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.clienteId,
                    referencedTable:
                        $$OrdemServicoTableTableReferences._clienteIdTable(db),
                    referencedColumn: $$OrdemServicoTableTableReferences
                        ._clienteIdTable(db)
                        .id,
                  ) as T;
                }
                if (formatoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.formatoId,
                    referencedTable:
                        $$OrdemServicoTableTableReferences._formatoIdTable(db),
                    referencedColumn: $$OrdemServicoTableTableReferences
                        ._formatoIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (fornecedorOrdemServicoTableRefs)
                    await $_getPrefetchedData<
                            OrdemServicoTableData,
                            $OrdemServicoTableTable,
                            FornecedorOrdemServicoTableData>(
                        currentTable: table,
                        referencedTable: $$OrdemServicoTableTableReferences
                            ._fornecedorOrdemServicoTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$OrdemServicoTableTableReferences(db, table, p0)
                                .fornecedorOrdemServicoTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.ordemServicoId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$OrdemServicoTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrdemServicoTableTable,
    OrdemServicoTableData,
    $$OrdemServicoTableTableFilterComposer,
    $$OrdemServicoTableTableOrderingComposer,
    $$OrdemServicoTableTableAnnotationComposer,
    $$OrdemServicoTableTableCreateCompanionBuilder,
    $$OrdemServicoTableTableUpdateCompanionBuilder,
    (OrdemServicoTableData, $$OrdemServicoTableTableReferences),
    OrdemServicoTableData,
    PrefetchHooks Function(
        {bool clienteId,
        bool formatoId,
        bool fornecedorOrdemServicoTableRefs})>;
typedef $$FornecedorOrdemServicoTableTableCreateCompanionBuilder
    = FornecedorOrdemServicoTableCompanion Function({
  Value<String> id,
  required int ordemServicoId,
  required String fornecedorId,
  Value<double> custo,
  Value<int> rowid,
});
typedef $$FornecedorOrdemServicoTableTableUpdateCompanionBuilder
    = FornecedorOrdemServicoTableCompanion Function({
  Value<String> id,
  Value<int> ordemServicoId,
  Value<String> fornecedorId,
  Value<double> custo,
  Value<int> rowid,
});

final class $$FornecedorOrdemServicoTableTableReferences extends BaseReferences<
    _$AppDatabase,
    $FornecedorOrdemServicoTableTable,
    FornecedorOrdemServicoTableData> {
  $$FornecedorOrdemServicoTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $OrdemServicoTableTable _ordemServicoIdTable(_$AppDatabase db) =>
      db.ordemServicoTable.createAlias($_aliasNameGenerator(
          db.fornecedorOrdemServicoTable.ordemServicoId,
          db.ordemServicoTable.id));

  $$OrdemServicoTableTableProcessedTableManager get ordemServicoId {
    final $_column = $_itemColumn<int>('ordem_servico_id')!;

    final manager =
        $$OrdemServicoTableTableTableManager($_db, $_db.ordemServicoTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ordemServicoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $FornecedorTableTable _fornecedorIdTable(_$AppDatabase db) =>
      db.fornecedorTable.createAlias($_aliasNameGenerator(
          db.fornecedorOrdemServicoTable.fornecedorId, db.fornecedorTable.id));

  $$FornecedorTableTableProcessedTableManager get fornecedorId {
    final $_column = $_itemColumn<String>('fornecedor_id')!;

    final manager =
        $$FornecedorTableTableTableManager($_db, $_db.fornecedorTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fornecedorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FornecedorOrdemServicoTableTableFilterComposer
    extends Composer<_$AppDatabase, $FornecedorOrdemServicoTableTable> {
  $$FornecedorOrdemServicoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get custo => $composableBuilder(
      column: $table.custo, builder: (column) => ColumnFilters(column));

  $$OrdemServicoTableTableFilterComposer get ordemServicoId {
    final $$OrdemServicoTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ordemServicoId,
        referencedTable: $db.ordemServicoTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdemServicoTableTableFilterComposer(
              $db: $db,
              $table: $db.ordemServicoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FornecedorTableTableFilterComposer get fornecedorId {
    final $$FornecedorTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fornecedorId,
        referencedTable: $db.fornecedorTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FornecedorTableTableFilterComposer(
              $db: $db,
              $table: $db.fornecedorTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FornecedorOrdemServicoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FornecedorOrdemServicoTableTable> {
  $$FornecedorOrdemServicoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get custo => $composableBuilder(
      column: $table.custo, builder: (column) => ColumnOrderings(column));

  $$OrdemServicoTableTableOrderingComposer get ordemServicoId {
    final $$OrdemServicoTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ordemServicoId,
        referencedTable: $db.ordemServicoTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdemServicoTableTableOrderingComposer(
              $db: $db,
              $table: $db.ordemServicoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FornecedorTableTableOrderingComposer get fornecedorId {
    final $$FornecedorTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fornecedorId,
        referencedTable: $db.fornecedorTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FornecedorTableTableOrderingComposer(
              $db: $db,
              $table: $db.fornecedorTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FornecedorOrdemServicoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FornecedorOrdemServicoTableTable> {
  $$FornecedorOrdemServicoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get custo =>
      $composableBuilder(column: $table.custo, builder: (column) => column);

  $$OrdemServicoTableTableAnnotationComposer get ordemServicoId {
    final $$OrdemServicoTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.ordemServicoId,
            referencedTable: $db.ordemServicoTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$OrdemServicoTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.ordemServicoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$FornecedorTableTableAnnotationComposer get fornecedorId {
    final $$FornecedorTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fornecedorId,
        referencedTable: $db.fornecedorTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FornecedorTableTableAnnotationComposer(
              $db: $db,
              $table: $db.fornecedorTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FornecedorOrdemServicoTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FornecedorOrdemServicoTableTable,
    FornecedorOrdemServicoTableData,
    $$FornecedorOrdemServicoTableTableFilterComposer,
    $$FornecedorOrdemServicoTableTableOrderingComposer,
    $$FornecedorOrdemServicoTableTableAnnotationComposer,
    $$FornecedorOrdemServicoTableTableCreateCompanionBuilder,
    $$FornecedorOrdemServicoTableTableUpdateCompanionBuilder,
    (
      FornecedorOrdemServicoTableData,
      $$FornecedorOrdemServicoTableTableReferences
    ),
    FornecedorOrdemServicoTableData,
    PrefetchHooks Function({bool ordemServicoId, bool fornecedorId})> {
  $$FornecedorOrdemServicoTableTableTableManager(
      _$AppDatabase db, $FornecedorOrdemServicoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FornecedorOrdemServicoTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$FornecedorOrdemServicoTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FornecedorOrdemServicoTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> ordemServicoId = const Value.absent(),
            Value<String> fornecedorId = const Value.absent(),
            Value<double> custo = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FornecedorOrdemServicoTableCompanion(
            id: id,
            ordemServicoId: ordemServicoId,
            fornecedorId: fornecedorId,
            custo: custo,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required int ordemServicoId,
            required String fornecedorId,
            Value<double> custo = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FornecedorOrdemServicoTableCompanion.insert(
            id: id,
            ordemServicoId: ordemServicoId,
            fornecedorId: fornecedorId,
            custo: custo,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FornecedorOrdemServicoTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {ordemServicoId = false, fornecedorId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (ordemServicoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.ordemServicoId,
                    referencedTable:
                        $$FornecedorOrdemServicoTableTableReferences
                            ._ordemServicoIdTable(db),
                    referencedColumn:
                        $$FornecedorOrdemServicoTableTableReferences
                            ._ordemServicoIdTable(db)
                            .id,
                  ) as T;
                }
                if (fornecedorId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.fornecedorId,
                    referencedTable:
                        $$FornecedorOrdemServicoTableTableReferences
                            ._fornecedorIdTable(db),
                    referencedColumn:
                        $$FornecedorOrdemServicoTableTableReferences
                            ._fornecedorIdTable(db)
                            .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FornecedorOrdemServicoTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FornecedorOrdemServicoTableTable,
    FornecedorOrdemServicoTableData,
    $$FornecedorOrdemServicoTableTableFilterComposer,
    $$FornecedorOrdemServicoTableTableOrderingComposer,
    $$FornecedorOrdemServicoTableTableAnnotationComposer,
    $$FornecedorOrdemServicoTableTableCreateCompanionBuilder,
    $$FornecedorOrdemServicoTableTableUpdateCompanionBuilder,
    (
      FornecedorOrdemServicoTableData,
      $$FornecedorOrdemServicoTableTableReferences
    ),
    FornecedorOrdemServicoTableData,
    PrefetchHooks Function({bool ordemServicoId, bool fornecedorId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FornecedorTableTableTableManager get fornecedorTable =>
      $$FornecedorTableTableTableManager(_db, _db.fornecedorTable);
  $$FormatoTableTableTableManager get formatoTable =>
      $$FormatoTableTableTableManager(_db, _db.formatoTable);
  $$ViaCoresTableTableTableManager get viaCoresTable =>
      $$ViaCoresTableTableTableManager(_db, _db.viaCoresTable);
  $$PapelTableTableTableManager get papelTable =>
      $$PapelTableTableTableManager(_db, _db.papelTable);
  $$UfTableTableTableManager get ufTable =>
      $$UfTableTableTableManager(_db, _db.ufTable);
  $$ClientesTableTableTableManager get clientesTable =>
      $$ClientesTableTableTableManager(_db, _db.clientesTable);
  $$OrdemServicoTableTableTableManager get ordemServicoTable =>
      $$OrdemServicoTableTableTableManager(_db, _db.ordemServicoTable);
  $$FornecedorOrdemServicoTableTableTableManager
      get fornecedorOrdemServicoTable =>
          $$FornecedorOrdemServicoTableTableTableManager(
              _db, _db.fornecedorOrdemServicoTable);
}
