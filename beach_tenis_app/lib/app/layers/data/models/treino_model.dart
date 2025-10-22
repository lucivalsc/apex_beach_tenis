///
/// Model para Treino - Beach Tênis App
///

enum StatusTreino { agendado, emAndamento, concluido, cancelado }

class ItemTreinoResultadoModel {
  final int itemTreinoId;
  final String nomeItem;
  final String? categoria;
  final int quantidadePrevista;
  final int? quantidadeExecutada;
  final int? acertos;
  final String? observacoes;

  ItemTreinoResultadoModel({
    required this.itemTreinoId,
    required this.nomeItem,
    this.categoria,
    required this.quantidadePrevista,
    this.quantidadeExecutada,
    this.acertos,
    this.observacoes,
  });

  factory ItemTreinoResultadoModel.fromJson(Map<String, dynamic> json) {
    return ItemTreinoResultadoModel(
      itemTreinoId: json['item_treino_id'] ?? 0,
      nomeItem: json['nome_item']?.toString() ?? '',
      categoria: json['categoria']?.toString(),
      quantidadePrevista: json['quantidade_prevista'] ?? 0,
      quantidadeExecutada: json['quantidade_executada'],
      acertos: json['acertos'],
      observacoes: json['observacoes']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_treino_id': itemTreinoId,
      'nome_item': nomeItem,
      'categoria': categoria,
      'quantidade_prevista': quantidadePrevista,
      'quantidade_executada': quantidadeExecutada,
      'acertos': acertos,
      'observacoes': observacoes,
    };
  }

  /// Getter para percentual de acerto
  double? get percentualAcerto {
    if (quantidadeExecutada == null || quantidadeExecutada == 0) return null;
    if (acertos == null) return null;
    return (acertos! / quantidadeExecutada!) * 100;
  }

  /// Verifica se o item foi executado
  bool get foiExecutado => quantidadeExecutada != null && quantidadeExecutada! > 0;

  /// Copia o resultado com novos valores
  ItemTreinoResultadoModel copyWith({
    int? itemTreinoId,
    String? nomeItem,
    String? categoria,
    int? quantidadePrevista,
    int? quantidadeExecutada,
    int? acertos,
    String? observacoes,
  }) {
    return ItemTreinoResultadoModel(
      itemTreinoId: itemTreinoId ?? this.itemTreinoId,
      nomeItem: nomeItem ?? this.nomeItem,
      categoria: categoria ?? this.categoria,
      quantidadePrevista: quantidadePrevista ?? this.quantidadePrevista,
      quantidadeExecutada: quantidadeExecutada ?? this.quantidadeExecutada,
      acertos: acertos ?? this.acertos,
      observacoes: observacoes ?? this.observacoes,
    );
  }

  @override
  String toString() {
    return 'ItemTreinoResultadoModel(item: $nomeItem, previsto: $quantidadePrevista, executado: $quantidadeExecutada, acertos: $acertos)';
  }
}

class TreinoModel {
  final int id;
  final String nome;
  final String? descricao;
  final DateTime dataAgendada;
  final DateTime? dataInicio;
  final DateTime? dataFim;
  final StatusTreino status;
  final int professorId;
  final String nomeProfessor;
  final int alunoId;
  final String nomeAluno;
  final int arenaId;
  final String nomeArena;
  final List<ItemTreinoResultadoModel> itens;
  final String? observacoesGerais;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TreinoModel({
    required this.id,
    required this.nome,
    this.descricao,
    required this.dataAgendada,
    this.dataInicio,
    this.dataFim,
    required this.status,
    required this.professorId,
    required this.nomeProfessor,
    required this.alunoId,
    required this.nomeAluno,
    required this.arenaId,
    required this.nomeArena,
    this.itens = const [],
    this.observacoesGerais,
    this.createdAt,
    this.updatedAt,
  });

  factory TreinoModel.fromJson(Map<String, dynamic> json) {
    List<ItemTreinoResultadoModel> itensList = [];
    if (json['itens'] != null) {
      itensList = (json['itens'] as List)
          .map((item) => ItemTreinoResultadoModel.fromJson(item))
          .toList();
    }

    return TreinoModel(
      id: json['id'] ?? 0,
      nome: json['nome']?.toString() ?? '',
      descricao: json['descricao']?.toString(),
      dataAgendada: json['data_agendada'] != null 
          ? DateTime.parse(json['data_agendada'].toString()) 
          : DateTime.now(),
      dataInicio: json['data_inicio'] != null 
          ? DateTime.tryParse(json['data_inicio'].toString()) 
          : null,
      dataFim: json['data_fim'] != null 
          ? DateTime.tryParse(json['data_fim'].toString()) 
          : null,
      status: _statusFromString(json['status']?.toString() ?? 'AGENDADO'),
      professorId: json['professor_id'] ?? 0,
      nomeProfessor: json['nome_professor']?.toString() ?? '',
      alunoId: json['aluno_id'] ?? 0,
      nomeAluno: json['nome_aluno']?.toString() ?? '',
      arenaId: json['arena_id'] ?? 0,
      nomeArena: json['nome_arena']?.toString() ?? '',
      itens: itensList,
      observacoesGerais: json['observacoes_gerais']?.toString(),
      createdAt: json['createdAt'] != null 
          ? DateTime.tryParse(json['createdAt'].toString()) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.tryParse(json['updatedAt'].toString()) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'data_agendada': dataAgendada.toIso8601String(),
      'data_inicio': dataInicio?.toIso8601String(),
      'data_fim': dataFim?.toIso8601String(),
      'status': _statusToString(status),
      'professor_id': professorId,
      'nome_professor': nomeProfessor,
      'aluno_id': alunoId,
      'nome_aluno': nomeAluno,
      'arena_id': arenaId,
      'nome_arena': nomeArena,
      'itens': itens.map((item) => item.toJson()).toList(),
      'observacoes_gerais': observacoesGerais,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Getter para status formatado
  String get statusFormatado {
    switch (status) {
      case StatusTreino.agendado:
        return 'Agendado';
      case StatusTreino.emAndamento:
        return 'Em Andamento';
      case StatusTreino.concluido:
        return 'Concluído';
      case StatusTreino.cancelado:
        return 'Cancelado';
    }
  }

  /// Getter para cor do status
  String get corStatus {
    switch (status) {
      case StatusTreino.agendado:
        return '#2196F3'; // Azul
      case StatusTreino.emAndamento:
        return '#FF9800'; // Laranja
      case StatusTreino.concluido:
        return '#4CAF50'; // Verde
      case StatusTreino.cancelado:
        return '#F44336'; // Vermelho
    }
  }

  /// Getter para duração do treino
  Duration? get duracao {
    if (dataInicio != null && dataFim != null) {
      return dataFim!.difference(dataInicio!);
    }
    return null;
  }

  /// Getter para duração formatada
  String get duracaoFormatada {
    final dur = duracao;
    if (dur == null) return 'N/A';
    final horas = dur.inHours;
    final minutos = dur.inMinutes.remainder(60);
    return '${horas}h ${minutos}min';
  }

  /// Verifica se o treino está concluído
  bool get isConcluido => status == StatusTreino.concluido;

  /// Verifica se pode ser editado pelo professor
  bool get podeSerEditadoPeloProfessor => 
      status == StatusTreino.agendado || status == StatusTreino.emAndamento;

  /// Verifica se pode ser preenchido pelo aluno
  bool get podeSerPreenchidoPeloAluno => 
      status == StatusTreino.agendado || status == StatusTreino.emAndamento;

  /// Quantidade total de itens
  int get quantidadeItens => itens.length;

  /// Quantidade de itens executados
  int get quantidadeItensExecutados => 
      itens.where((item) => item.foiExecutado).length;

  /// Percentual de progresso do treino
  double get percentualProgresso {
    if (quantidadeItens == 0) return 0;
    return (quantidadeItensExecutados / quantidadeItens) * 100;
  }

  /// Verifica se todos os itens foram executados
  bool get todosItensExecutados => 
      quantidadeItens > 0 && quantidadeItensExecutados == quantidadeItens;

  /// Getters para compatibilidade com código antigo
  String? get observacoes => observacoesGerais;
  
  bool get isPreenchido => status == StatusTreino.concluido || todosItensExecutados;
  
  DateTime get data => dataAgendada;

  /// Copia o treino com novos valores
  TreinoModel copyWith({
    int? id,
    String? nome,
    String? descricao,
    DateTime? dataAgendada,
    DateTime? dataInicio,
    DateTime? dataFim,
    StatusTreino? status,
    int? professorId,
    String? nomeProfessor,
    int? alunoId,
    String? nomeAluno,
    int? arenaId,
    String? nomeArena,
    List<ItemTreinoResultadoModel>? itens,
    String? observacoesGerais,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TreinoModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      dataAgendada: dataAgendada ?? this.dataAgendada,
      dataInicio: dataInicio ?? this.dataInicio,
      dataFim: dataFim ?? this.dataFim,
      status: status ?? this.status,
      professorId: professorId ?? this.professorId,
      nomeProfessor: nomeProfessor ?? this.nomeProfessor,
      alunoId: alunoId ?? this.alunoId,
      nomeAluno: nomeAluno ?? this.nomeAluno,
      arenaId: arenaId ?? this.arenaId,
      nomeArena: nomeArena ?? this.nomeArena,
      itens: itens ?? this.itens,
      observacoesGerais: observacoesGerais ?? this.observacoesGerais,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'TreinoModel(id: $id, nome: $nome, status: $statusFormatado, professor: $nomeProfessor, aluno: $nomeAluno)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TreinoModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Função utilitária para converter string em StatusTreino
StatusTreino _statusFromString(String status) {
  switch (status.toUpperCase()) {
    case 'AGENDADO':
      return StatusTreino.agendado;
    case 'EM_ANDAMENTO':
    case 'EMANDAMENTO':
      return StatusTreino.emAndamento;
    case 'CONCLUIDO':
    case 'CONCLUÍDO':
      return StatusTreino.concluido;
    case 'CANCELADO':
      return StatusTreino.cancelado;
    default:
      return StatusTreino.agendado;
  }
}

/// Função utilitária para converter StatusTreino em string
String _statusToString(StatusTreino status) {
  switch (status) {
    case StatusTreino.agendado:
      return 'AGENDADO';
    case StatusTreino.emAndamento:
      return 'EM_ANDAMENTO';
    case StatusTreino.concluido:
      return 'CONCLUIDO';
    case StatusTreino.cancelado:
      return 'CANCELADO';
  }
}