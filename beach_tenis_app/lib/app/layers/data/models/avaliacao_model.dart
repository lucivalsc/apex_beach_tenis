///
/// Model para Avaliação - Beach Tênis App
///

enum StatusAvaliacao { agendada, emAndamento, concluida, cancelada }
enum ResultadoAvaliacao { aprovado, reprovado, pendente }

class ItemAvaliacaoResultadoModel {
  final int itemAvaliacaoId;
  final String nomeItem;
  final String? categoria;
  final int quantidadePrevista;
  final int? quantidadeExecutada;
  final int? acertos;
  final String? observacoes;

  ItemAvaliacaoResultadoModel({
    required this.itemAvaliacaoId,
    required this.nomeItem,
    this.categoria,
    required this.quantidadePrevista,
    this.quantidadeExecutada,
    this.acertos,
    this.observacoes,
  });

  factory ItemAvaliacaoResultadoModel.fromJson(Map<String, dynamic> json) {
    return ItemAvaliacaoResultadoModel(
      itemAvaliacaoId: json['item_avaliacao_id'] ?? 0,
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
      'item_avaliacao_id': itemAvaliacaoId,
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

  /// Verifica se o item foi avaliado
  bool get foiAvaliado => quantidadeExecutada != null && quantidadeExecutada! > 0;

  /// Verifica se o item foi aprovado (70% ou mais de acerto)
  bool? get foiAprovado {
    final percentual = percentualAcerto;
    if (percentual == null) return null;
    return percentual >= 70.0;
  }

  /// Copia o resultado com novos valores
  ItemAvaliacaoResultadoModel copyWith({
    int? itemAvaliacaoId,
    String? nomeItem,
    String? categoria,
    int? quantidadePrevista,
    int? quantidadeExecutada,
    int? acertos,
    String? observacoes,
  }) {
    return ItemAvaliacaoResultadoModel(
      itemAvaliacaoId: itemAvaliacaoId ?? this.itemAvaliacaoId,
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
    return 'ItemAvaliacaoResultadoModel(item: $nomeItem, previsto: $quantidadePrevista, executado: $quantidadeExecutada, acertos: $acertos)';
  }
}

class AvaliacaoModel {
  final int id;
  final String nome;
  final String? descricao;
  final DateTime dataAgendada;
  final DateTime? dataInicio;
  final DateTime? dataFim;
  final StatusAvaliacao status;
  final ResultadoAvaliacao resultado;
  final int professorId;
  final String nomeProfessor;
  final int alunoId;
  final String nomeAluno;
  final int arenaId;
  final String nomeArena;
  final List<ItemAvaliacaoResultadoModel> itens;
  final String? observacoesGerais;
  final double? notaFinal; // 0-10
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AvaliacaoModel({
    required this.id,
    required this.nome,
    this.descricao,
    required this.dataAgendada,
    this.dataInicio,
    this.dataFim,
    required this.status,
    required this.resultado,
    required this.professorId,
    required this.nomeProfessor,
    required this.alunoId,
    required this.nomeAluno,
    required this.arenaId,
    required this.nomeArena,
    this.itens = const [],
    this.observacoesGerais,
    this.notaFinal,
    this.createdAt,
    this.updatedAt,
  });

  factory AvaliacaoModel.fromJson(Map<String, dynamic> json) {
    List<ItemAvaliacaoResultadoModel> itensList = [];
    if (json['itens'] != null) {
      itensList = (json['itens'] as List)
          .map((item) => ItemAvaliacaoResultadoModel.fromJson(item))
          .toList();
    }

    return AvaliacaoModel(
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
      status: _statusFromString(json['status']?.toString() ?? 'AGENDADA'),
      resultado: _resultadoFromString(json['resultado']?.toString() ?? 'PENDENTE'),
      professorId: json['professor_id'] ?? 0,
      nomeProfessor: json['nome_professor']?.toString() ?? '',
      alunoId: json['aluno_id'] ?? 0,
      nomeAluno: json['nome_aluno']?.toString() ?? '',
      arenaId: json['arena_id'] ?? 0,
      nomeArena: json['nome_arena']?.toString() ?? '',
      itens: itensList,
      observacoesGerais: json['observacoes_gerais']?.toString(),
      notaFinal: json['nota_final']?.toDouble(),
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
      'resultado': _resultadoToString(resultado),
      'professor_id': professorId,
      'nome_professor': nomeProfessor,
      'aluno_id': alunoId,
      'nome_aluno': nomeAluno,
      'arena_id': arenaId,
      'nome_arena': nomeArena,
      'itens': itens.map((item) => item.toJson()).toList(),
      'observacoes_gerais': observacoesGerais,
      'nota_final': notaFinal,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Getter para status formatado
  String get statusFormatado {
    switch (status) {
      case StatusAvaliacao.agendada:
        return 'Agendada';
      case StatusAvaliacao.emAndamento:
        return 'Em Andamento';
      case StatusAvaliacao.concluida:
        return 'Concluída';
      case StatusAvaliacao.cancelada:
        return 'Cancelada';
    }
  }

  /// Getter para resultado formatado
  String get resultadoFormatado {
    switch (resultado) {
      case ResultadoAvaliacao.aprovado:
        return 'Aprovado';
      case ResultadoAvaliacao.reprovado:
        return 'Reprovado';
      case ResultadoAvaliacao.pendente:
        return 'Pendente';
    }
  }

  /// Getter para cor do status
  String get corStatus {
    switch (status) {
      case StatusAvaliacao.agendada:
        return '#2196F3'; // Azul
      case StatusAvaliacao.emAndamento:
        return '#FF9800'; // Laranja
      case StatusAvaliacao.concluida:
        return '#4CAF50'; // Verde
      case StatusAvaliacao.cancelada:
        return '#F44336'; // Vermelho
    }
  }

  /// Getter para cor do resultado
  String get corResultado {
    switch (resultado) {
      case ResultadoAvaliacao.aprovado:
        return '#4CAF50'; // Verde
      case ResultadoAvaliacao.reprovado:
        return '#F44336'; // Vermelho
      case ResultadoAvaliacao.pendente:
        return '#9E9E9E'; // Cinza
    }
  }

  /// Getter para duração da avaliação
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

  /// Verifica se a avaliação está concluída
  bool get isConcluida => status == StatusAvaliacao.concluida;

  /// Verifica se pode ser editada apenas pelo professor que criou
  bool get podeSerEditadaPeloProfessor => 
      status == StatusAvaliacao.agendada || status == StatusAvaliacao.emAndamento;

  /// Quantidade total de itens
  int get quantidadeItens => itens.length;

  /// Quantidade de itens avaliados
  int get quantidadeItensAvaliados => 
      itens.where((item) => item.foiAvaliado).length;

  /// Percentual de progresso da avaliação
  double get percentualProgresso {
    if (quantidadeItens == 0) return 0;
    return (quantidadeItensAvaliados / quantidadeItens) * 100;
  }

  /// Verifica se todos os itens foram avaliados
  bool get todosItensAvaliados => 
      quantidadeItens > 0 && quantidadeItensAvaliados == quantidadeItens;

  /// Calcula a nota final baseada nos percentuais dos itens
  double? get notaCalculada {
    if (itens.isEmpty) return null;
    
    final itensAvaliados = itens.where((item) => item.foiAvaliado).toList();
    if (itensAvaliados.isEmpty) return null;
    
    double somaPercentuais = 0;
    for (final item in itensAvaliados) {
      final percentual = item.percentualAcerto;
      if (percentual != null) {
        somaPercentuais += percentual;
      }
    }
    
    return (somaPercentuais / itensAvaliados.length) / 10; // Converte para escala 0-10
  }

  /// Copia a avaliação com novos valores
  AvaliacaoModel copyWith({
    int? id,
    String? nome,
    String? descricao,
    DateTime? dataAgendada,
    DateTime? dataInicio,
    DateTime? dataFim,
    StatusAvaliacao? status,
    ResultadoAvaliacao? resultado,
    int? professorId,
    String? nomeProfessor,
    int? alunoId,
    String? nomeAluno,
    int? arenaId,
    String? nomeArena,
    List<ItemAvaliacaoResultadoModel>? itens,
    String? observacoesGerais,
    double? notaFinal,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AvaliacaoModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      dataAgendada: dataAgendada ?? this.dataAgendada,
      dataInicio: dataInicio ?? this.dataInicio,
      dataFim: dataFim ?? this.dataFim,
      status: status ?? this.status,
      resultado: resultado ?? this.resultado,
      professorId: professorId ?? this.professorId,
      nomeProfessor: nomeProfessor ?? this.nomeProfessor,
      alunoId: alunoId ?? this.alunoId,
      nomeAluno: nomeAluno ?? this.nomeAluno,
      arenaId: arenaId ?? this.arenaId,
      nomeArena: nomeArena ?? this.nomeArena,
      itens: itens ?? this.itens,
      observacoesGerais: observacoesGerais ?? this.observacoesGerais,
      notaFinal: notaFinal ?? this.notaFinal,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'AvaliacaoModel(id: $id, nome: $nome, status: $statusFormatado, resultado: $resultadoFormatado, professor: $nomeProfessor, aluno: $nomeAluno)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AvaliacaoModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Função utilitária para converter string em StatusAvaliacao
StatusAvaliacao _statusFromString(String status) {
  switch (status.toUpperCase()) {
    case 'AGENDADA':
      return StatusAvaliacao.agendada;
    case 'EM_ANDAMENTO':
    case 'EMANDAMENTO':
      return StatusAvaliacao.emAndamento;
    case 'CONCLUIDA':
    case 'CONCLUÍDA':
      return StatusAvaliacao.concluida;
    case 'CANCELADA':
      return StatusAvaliacao.cancelada;
    default:
      return StatusAvaliacao.agendada;
  }
}

/// Função utilitária para converter StatusAvaliacao em string
String _statusToString(StatusAvaliacao status) {
  switch (status) {
    case StatusAvaliacao.agendada:
      return 'AGENDADA';
    case StatusAvaliacao.emAndamento:
      return 'EM_ANDAMENTO';
    case StatusAvaliacao.concluida:
      return 'CONCLUIDA';
    case StatusAvaliacao.cancelada:
      return 'CANCELADA';
  }
}

/// Função utilitária para converter string em ResultadoAvaliacao
ResultadoAvaliacao _resultadoFromString(String resultado) {
  switch (resultado.toUpperCase()) {
    case 'APROVADO':
      return ResultadoAvaliacao.aprovado;
    case 'REPROVADO':
      return ResultadoAvaliacao.reprovado;
    case 'PENDENTE':
      return ResultadoAvaliacao.pendente;
    default:
      return ResultadoAvaliacao.pendente;
  }
}

/// Função utilitária para converter ResultadoAvaliacao em string
String _resultadoToString(ResultadoAvaliacao resultado) {
  switch (resultado) {
    case ResultadoAvaliacao.aprovado:
      return 'APROVADO';
    case ResultadoAvaliacao.reprovado:
      return 'REPROVADO';
    case ResultadoAvaliacao.pendente:
      return 'PENDENTE';
  }
}