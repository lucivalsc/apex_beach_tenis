///
/// Model para Item de Treino - Beach Tênis App
///

class CategoriaTreinoModel {
  final int id;
  final String nome;
  final String? descricao;
  final String? cor; // Hex color
  final bool ativo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CategoriaTreinoModel({
    required this.id,
    required this.nome,
    this.descricao,
    this.cor,
    required this.ativo,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoriaTreinoModel.fromJson(Map<String, dynamic> json) {
    return CategoriaTreinoModel(
      id: json['id'] ?? 0,
      nome: json['nome']?.toString() ?? '',
      descricao: json['descricao']?.toString(),
      cor: json['cor']?.toString(),
      ativo: json['ativo'] ?? true,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'cor': cor,
      'ativo': ativo,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  String toString() => 'CategoriaTreinoModel(id: $id, nome: $nome)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoriaTreinoModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class ItemTreinoModel {
  final int id;
  final String nome;
  final String descricao;
  final int categoriaId;
  final String nomeCategoria;
  final int quantidadePadrao; // Quantidade padrão sugerida
  final String? instrucoes; // Instruções de como executar
  final String? dificuldade; // FÁCIL, MÉDIO, DIFÍCIL
  final String? golpesEnvolvidos; // Lista de golpes separados por vírgula
  final bool ativo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ItemTreinoModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.categoriaId,
    required this.nomeCategoria,
    required this.quantidadePadrao,
    this.instrucoes,
    this.dificuldade,
    this.golpesEnvolvidos,
    required this.ativo,
    this.createdAt,
    this.updatedAt,
  });

  factory ItemTreinoModel.fromJson(Map<String, dynamic> json) {
    return ItemTreinoModel(
      id: json['id'] ?? 0,
      nome: json['nome']?.toString() ?? '',
      descricao: json['descricao']?.toString() ?? '',
      categoriaId: json['categoria_id'] ?? 0,
      nomeCategoria: json['nome_categoria']?.toString() ?? '',
      quantidadePadrao: json['quantidade_padrao'] ?? 10,
      instrucoes: json['instrucoes']?.toString(),
      dificuldade: json['dificuldade']?.toString(),
      golpesEnvolvidos: json['golpes_envolvidos']?.toString(),
      ativo: json['ativo'] ?? true,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'categoria_id': categoriaId,
      'nome_categoria': nomeCategoria,
      'quantidade_padrao': quantidadePadrao,
      'instrucoes': instrucoes,
      'dificuldade': dificuldade,
      'golpes_envolvidos': golpesEnvolvidos,
      'ativo': ativo,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Getter para cor da dificuldade
  String get corDificuldade {
    switch (dificuldade?.toUpperCase()) {
      case 'FÁCIL':
      case 'FACIL':
        return '#4CAF50'; // Verde
      case 'MÉDIO':
      case 'MEDIO':
        return '#FF9800'; // Laranja
      case 'DIFÍCIL':
      case 'DIFICIL':
        return '#F44336'; // Vermelho
      default:
        return '#9E9E9E'; // Cinza
    }
  }

  /// Getter para lista de golpes
  List<String> get listaGolpes {
    if (golpesEnvolvidos == null || golpesEnvolvidos!.isEmpty) return [];
    return golpesEnvolvidos!.split(',').map((g) => g.trim()).toList();
  }

  /// Verifica se tem instruções
  bool get temInstrucoes => instrucoes != null && instrucoes!.isNotEmpty;

  /// Verifica se tem golpes definidos
  bool get temGolpes => golpesEnvolvidos != null && golpesEnvolvidos!.isNotEmpty;

  /// Copia o item com novos valores
  ItemTreinoModel copyWith({
    int? id,
    String? nome,
    String? descricao,
    int? categoriaId,
    String? nomeCategoria,
    int? quantidadePadrao,
    String? instrucoes,
    String? dificuldade,
    String? golpesEnvolvidos,
    bool? ativo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ItemTreinoModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      categoriaId: categoriaId ?? this.categoriaId,
      nomeCategoria: nomeCategoria ?? this.nomeCategoria,
      quantidadePadrao: quantidadePadrao ?? this.quantidadePadrao,
      instrucoes: instrucoes ?? this.instrucoes,
      dificuldade: dificuldade ?? this.dificuldade,
      golpesEnvolvidos: golpesEnvolvidos ?? this.golpesEnvolvidos,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'ItemTreinoModel(id: $id, nome: $nome, categoria: $nomeCategoria, dificuldade: $dificuldade)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ItemTreinoModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class GolpeModel {
  final int id;
  final String nome;
  final String? descricao;
  final String? tipo; // OFENSIVO, DEFENSIVO, NEUTRAL
  final String? categoria; // SAQUE, DEVOLUCAO, RALLY
  final String? instrucoes;
  final bool ativo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GolpeModel({
    required this.id,
    required this.nome,
    this.descricao,
    this.tipo,
    this.categoria,
    this.instrucoes,
    required this.ativo,
    this.createdAt,
    this.updatedAt,
  });

  factory GolpeModel.fromJson(Map<String, dynamic> json) {
    return GolpeModel(
      id: json['id'] ?? 0,
      nome: json['nome']?.toString() ?? '',
      descricao: json['descricao']?.toString(),
      tipo: json['tipo']?.toString(),
      categoria: json['categoria']?.toString(),
      instrucoes: json['instrucoes']?.toString(),
      ativo: json['ativo'] ?? true,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'tipo': tipo,
      'categoria': categoria,
      'instrucoes': instrucoes,
      'ativo': ativo,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Getter para cor do tipo
  String get corTipo {
    switch (tipo?.toUpperCase()) {
      case 'OFENSIVO':
        return '#F44336'; // Vermelho
      case 'DEFENSIVO':
        return '#2196F3'; // Azul
      case 'NEUTRAL':
        return '#9E9E9E'; // Cinza
      default:
        return '#9E9E9E'; // Cinza
    }
  }

  /// Getter para cor da categoria
  String get corCategoria {
    switch (categoria?.toUpperCase()) {
      case 'SAQUE':
        return '#4CAF50'; // Verde
      case 'DEVOLUCAO':
      case 'DEVOLUÇÃO':
        return '#FF9800'; // Laranja
      case 'RALLY':
        return '#9C27B0'; // Roxo
      default:
        return '#9E9E9E'; // Cinza
    }
  }

  /// Verifica se tem instruções
  bool get temInstrucoes => instrucoes != null && instrucoes!.isNotEmpty;

  /// Copia o golpe com novos valores
  GolpeModel copyWith({
    int? id,
    String? nome,
    String? descricao,
    String? tipo,
    String? categoria,
    String? instrucoes,
    bool? ativo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GolpeModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      tipo: tipo ?? this.tipo,
      categoria: categoria ?? this.categoria,
      instrucoes: instrucoes ?? this.instrucoes,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'GolpeModel(id: $id, nome: $nome, tipo: $tipo, categoria: $categoria)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GolpeModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
