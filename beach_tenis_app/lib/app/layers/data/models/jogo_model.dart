///
/// Model para Jogo - Beach Tênis App
///

enum TipoJogo { simples, duplas }
enum StatusJogo { agendado, emAndamento, finalizado, cancelado }

class JogadorModel {
  final int atletaId;
  final String nome;
  final String? foto;

  JogadorModel({
    required this.atletaId,
    required this.nome,
    this.foto,
  });

  factory JogadorModel.fromJson(Map<String, dynamic> json) {
    return JogadorModel(
      atletaId: json['atleta_id'] ?? 0,
      nome: json['nome']?.toString() ?? '',
      foto: json['foto']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'atleta_id': atletaId,
      'nome': nome,
      'foto': foto,
    };
  }

  @override
  String toString() => 'JogadorModel(id: $atletaId, nome: $nome)';
}

class PlacarModel {
  final int set1Jogador1;
  final int set1Jogador2;
  final int? set2Jogador1;
  final int? set2Jogador2;
  final int? set3Jogador1;
  final int? set3Jogador2;
  final int? tiebreakJogador1;
  final int? tiebreakJogador2;

  PlacarModel({
    this.set1Jogador1 = 0,
    this.set1Jogador2 = 0,
    this.set2Jogador1,
    this.set2Jogador2,
    this.set3Jogador1,
    this.set3Jogador2,
    this.tiebreakJogador1,
    this.tiebreakJogador2,
  });

  factory PlacarModel.fromJson(Map<String, dynamic> json) {
    return PlacarModel(
      set1Jogador1: json['set1_jogador1'] ?? 0,
      set1Jogador2: json['set1_jogador2'] ?? 0,
      set2Jogador1: json['set2_jogador1'],
      set2Jogador2: json['set2_jogador2'],
      set3Jogador1: json['set3_jogador1'],
      set3Jogador2: json['set3_jogador2'],
      tiebreakJogador1: json['tiebreak_jogador1'],
      tiebreakJogador2: json['tiebreak_jogador2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'set1_jogador1': set1Jogador1,
      'set1_jogador2': set1Jogador2,
      'set2_jogador1': set2Jogador1,
      'set2_jogador2': set2Jogador2,
      'set3_jogador1': set3Jogador1,
      'set3_jogador2': set3Jogador2,
      'tiebreak_jogador1': tiebreakJogador1,
      'tiebreak_jogador2': tiebreakJogador2,
    };
  }

  /// Getter para placar formatado
  String get placarFormatado {
    String placar = '$set1Jogador1-$set1Jogador2';
    if (set2Jogador1 != null && set2Jogador2 != null) {
      placar += ', $set2Jogador1-$set2Jogador2';
    }
    if (set3Jogador1 != null && set3Jogador2 != null) {
      placar += ', $set3Jogador1-$set3Jogador2';
    }
    if (tiebreakJogador1 != null && tiebreakJogador2 != null) {
      placar += ' ($tiebreakJogador1-$tiebreakJogador2)';
    }
    return placar;
  }
}

class JogoModel {
  final int id;
  final TipoJogo tipo;
  final DateTime? dataHora;
  final DateTime? dataInicio;
  final DateTime? dataFim;
  final String? local;
  final int? arenaId;
  final String? nomeArena;
  final StatusJogo status;
  final JogadorModel jogador1;
  final JogadorModel? jogador2; // Para duplas
  final JogadorModel adversario1;
  final JogadorModel? adversario2; // Para duplas
  final PlacarModel? placar;
  final int? vencedorTime; // 1 ou 2
  final String? observacoes;
  final List<int> administradoresTecnicos; // IDs dos profissionais técnicos
  final DateTime? createdAt;
  final DateTime? updatedAt;

  JogoModel({
    required this.id,
    required this.tipo,
    this.dataHora,
    this.dataInicio,
    this.dataFim,
    this.local,
    this.arenaId,
    this.nomeArena,
    required this.status,
    required this.jogador1,
    this.jogador2,
    required this.adversario1,
    this.adversario2,
    this.placar,
    this.vencedorTime,
    this.observacoes,
    this.administradoresTecnicos = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory JogoModel.fromJson(Map<String, dynamic> json) {
    return JogoModel(
      id: json['id'] ?? 0,
      tipo: json['tipo'] == 'DUPLAS' ? TipoJogo.duplas : TipoJogo.simples,
      dataHora: json['data_hora'] != null 
          ? DateTime.tryParse(json['data_hora'].toString()) 
          : null,
      dataInicio: json['data_inicio'] != null 
          ? DateTime.tryParse(json['data_inicio'].toString()) 
          : null,
      dataFim: json['data_fim'] != null 
          ? DateTime.tryParse(json['data_fim'].toString()) 
          : null,
      local: json['local']?.toString(),
      arenaId: json['arena_id'],
      nomeArena: json['nome_arena']?.toString(),
      status: _statusFromString(json['status']?.toString() ?? 'AGENDADO'),
      jogador1: JogadorModel.fromJson(json['jogador1'] ?? {}),
      jogador2: json['jogador2'] != null 
          ? JogadorModel.fromJson(json['jogador2']) 
          : null,
      adversario1: JogadorModel.fromJson(json['adversario1'] ?? {}),
      adversario2: json['adversario2'] != null 
          ? JogadorModel.fromJson(json['adversario2']) 
          : null,
      placar: json['placar'] != null 
          ? PlacarModel.fromJson(json['placar']) 
          : null,
      vencedorTime: json['vencedor_time'],
      observacoes: json['observacoes']?.toString(),
      administradoresTecnicos: json['administradores_tecnicos'] != null 
          ? List<int>.from(json['administradores_tecnicos']) 
          : [],
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
      'tipo': tipo == TipoJogo.duplas ? 'DUPLAS' : 'SIMPLES',
      'data_hora': dataHora?.toIso8601String(),
      'data_inicio': dataInicio?.toIso8601String(),
      'data_fim': dataFim?.toIso8601String(),
      'local': local,
      'arena_id': arenaId,
      'nome_arena': nomeArena,
      'status': _statusToString(status),
      'jogador1': jogador1.toJson(),
      'jogador2': jogador2?.toJson(),
      'adversario1': adversario1.toJson(),
      'adversario2': adversario2?.toJson(),
      'placar': placar?.toJson(),
      'vencedor_time': vencedorTime,
      'observacoes': observacoes,
      'administradores_tecnicos': administradoresTecnicos,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Getter para tipo formatado
  String get tipoFormatado {
    return tipo == TipoJogo.duplas ? 'Duplas' : 'Simples';
  }

  /// Getter para status formatado
  String get statusFormatado {
    switch (status) {
      case StatusJogo.agendado:
        return 'Agendado';
      case StatusJogo.emAndamento:
        return 'Em Andamento';
      case StatusJogo.finalizado:
        return 'Finalizado';
      case StatusJogo.cancelado:
        return 'Cancelado';
    }
  }

  /// Getter para cor do status
  String get corStatus {
    switch (status) {
      case StatusJogo.agendado:
        return '#2196F3'; // Azul
      case StatusJogo.emAndamento:
        return '#FF9800'; // Laranja
      case StatusJogo.finalizado:
        return '#4CAF50'; // Verde
      case StatusJogo.cancelado:
        return '#F44336'; // Vermelho
    }
  }

  /// Getter para duração do jogo
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

  /// Verifica se é um jogo em duplas
  bool get isDuplas => tipo == TipoJogo.duplas;

  /// Verifica se o jogo está finalizado
  bool get isFinalizado => status == StatusJogo.finalizado;

  /// Verifica se tem administrador técnico
  bool get temAdministradorTecnico => administradoresTecnicos.isNotEmpty;

  /// Getter para nome dos jogadores (time 1)
  String get nomesTime1 {
    if (isDuplas && jogador2 != null) {
      return '${jogador1.nome} / ${jogador2!.nome}';
    }
    return jogador1.nome;
  }

  /// Getter para nome dos adversários (time 2)
  String get nomesTime2 {
    if (isDuplas && adversario2 != null) {
      return '${adversario1.nome} / ${adversario2!.nome}';
    }
    return adversario1.nome;
  }

  /// Getters para compatibilidade com código antigo
  int get atleta1Id => jogador1.atletaId;
  int get atleta2Id => adversario1.atletaId;
  int? get atleta3Id => jogador2?.atletaId;
  int? get atleta4Id => adversario2?.atletaId;

  String get nomeAtleta1 => jogador1.nome;
  String get nomeAtleta2 => adversario1.nome;
  String? get nomeAtleta3 => jogador2?.nome;
  String? get nomeAtleta4 => adversario2?.nome;

  TipoJogo get tipoJogo => tipo;

  bool get vencedorTime1 => vencedorTime == 1;
  bool get vencedorTime2 => vencedorTime == 2;

  /// Copia o jogo com novos valores
  JogoModel copyWith({
    int? id,
    TipoJogo? tipo,
    DateTime? dataHora,
    DateTime? dataInicio,
    DateTime? dataFim,
    String? local,
    int? arenaId,
    String? nomeArena,
    StatusJogo? status,
    JogadorModel? jogador1,
    JogadorModel? jogador2,
    JogadorModel? adversario1,
    JogadorModel? adversario2,
    PlacarModel? placar,
    int? vencedorTime,
    String? observacoes,
    List<int>? administradoresTecnicos,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return JogoModel(
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      dataHora: dataHora ?? this.dataHora,
      dataInicio: dataInicio ?? this.dataInicio,
      dataFim: dataFim ?? this.dataFim,
      local: local ?? this.local,
      arenaId: arenaId ?? this.arenaId,
      nomeArena: nomeArena ?? this.nomeArena,
      status: status ?? this.status,
      jogador1: jogador1 ?? this.jogador1,
      jogador2: jogador2 ?? this.jogador2,
      adversario1: adversario1 ?? this.adversario1,
      adversario2: adversario2 ?? this.adversario2,
      placar: placar ?? this.placar,
      vencedorTime: vencedorTime ?? this.vencedorTime,
      observacoes: observacoes ?? this.observacoes,
      administradoresTecnicos: administradoresTecnicos ?? this.administradoresTecnicos,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'JogoModel(id: $id, tipo: $tipoFormatado, status: $statusFormatado, jogadores: $nomesTime1 vs $nomesTime2)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is JogoModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Função utilitária para converter string em StatusJogo
StatusJogo _statusFromString(String status) {
  switch (status.toUpperCase()) {
    case 'AGENDADO':
      return StatusJogo.agendado;
    case 'EM_ANDAMENTO':
    case 'EMANDAMENTO':
      return StatusJogo.emAndamento;
    case 'FINALIZADO':
      return StatusJogo.finalizado;
    case 'CANCELADO':
      return StatusJogo.cancelado;
    default:
      return StatusJogo.agendado;
  }
}

/// Função utilitária para converter StatusJogo em string
String _statusToString(StatusJogo status) {
  switch (status) {
    case StatusJogo.agendado:
      return 'AGENDADO';
    case StatusJogo.emAndamento:
      return 'EM_ANDAMENTO';
    case StatusJogo.finalizado:
      return 'FINALIZADO';
    case StatusJogo.cancelado:
      return 'CANCELADO';
  }
}