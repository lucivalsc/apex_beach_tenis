///
/// Model para Conexão/Amizade - Beach Tênis App
/// Gerencia as conexões entre atletas e solicitações de amizade
///

enum StatusConexao {
  PENDENTE,
  ACEITA,
  RECUSADA,
  BLOQUEADA,
}

enum TipoConexao {
  AMIZADE,
  PARCERIA,
  ADVERSARIO_PREFERIDO,
}

class ConexaoModel {
  final int id;
  final int atletaSolicitanteId;
  final String nomeSolicitante;
  final String? fotoSolicitante;
  final int atletaDestinatarioId;
  final String nomeDestinatario;
  final String? fotoDestinatario;
  final TipoConexao tipoConexao;
  final StatusConexao status;
  final String? mensagem;
  final DateTime dataSolicitacao;
  final DateTime? dataResposta;
  final int? totalJogosJuntos; // Para parcerias
  final int? vitoriasSolicitante; // Para adversários
  final int? vitoriasDestinatario; // Para adversários
  final double? avaliacaoSolicitante; // 1-5 estrelas
  final double? avaliacaoDestinatario; // 1-5 estrelas
  final bool notificacaoEnviada;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ConexaoModel({
    required this.id,
    required this.atletaSolicitanteId,
    required this.nomeSolicitante,
    this.fotoSolicitante,
    required this.atletaDestinatarioId,
    required this.nomeDestinatario,
    this.fotoDestinatario,
    required this.tipoConexao,
    required this.status,
    this.mensagem,
    required this.dataSolicitacao,
    this.dataResposta,
    this.totalJogosJuntos,
    this.vitoriasSolicitante,
    this.vitoriasDestinatario,
    this.avaliacaoSolicitante,
    this.avaliacaoDestinatario,
    required this.notificacaoEnviada,
    this.createdAt,
    this.updatedAt,
  });

  factory ConexaoModel.fromJson(Map<String, dynamic> json) {
    return ConexaoModel(
      id: json['id'] ?? 0,
      atletaSolicitanteId: json['atleta_solicitante_id'] ?? 0,
      nomeSolicitante: json['nome_solicitante']?.toString() ?? '',
      fotoSolicitante: json['foto_solicitante']?.toString(),
      atletaDestinatarioId: json['atleta_destinatario_id'] ?? 0,
      nomeDestinatario: json['nome_destinatario']?.toString() ?? '',
      fotoDestinatario: json['foto_destinatario']?.toString(),
      tipoConexao: _parseTipoConexao(json['tipo_conexao']),
      status: _parseStatusConexao(json['status']),
      mensagem: json['mensagem']?.toString(),
      dataSolicitacao:
          DateTime.tryParse(json['data_solicitacao']?.toString() ?? '') ??
              DateTime.now(),
      dataResposta: json['data_resposta'] != null
          ? DateTime.tryParse(json['data_resposta'].toString())
          : null,
      totalJogosJuntos: json['total_jogos_juntos'],
      vitoriasSolicitante: json['vitorias_solicitante'],
      vitoriasDestinatario: json['vitorias_destinatario'],
      avaliacaoSolicitante: json['avaliacao_solicitante']?.toDouble(),
      avaliacaoDestinatario: json['avaliacao_destinatario']?.toDouble(),
      notificacaoEnviada: json['notificacao_enviada'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
    );
  }

  static TipoConexao _parseTipoConexao(dynamic tipo) {
    switch (tipo?.toString().toUpperCase()) {
      case 'AMIZADE':
        return TipoConexao.AMIZADE;
      case 'PARCERIA':
        return TipoConexao.PARCERIA;
      case 'ADVERSARIO_PREFERIDO':
        return TipoConexao.ADVERSARIO_PREFERIDO;
      default:
        return TipoConexao.AMIZADE;
    }
  }

  static StatusConexao _parseStatusConexao(dynamic status) {
    switch (status?.toString().toUpperCase()) {
      case 'PENDENTE':
        return StatusConexao.PENDENTE;
      case 'ACEITA':
        return StatusConexao.ACEITA;
      case 'RECUSADA':
        return StatusConexao.RECUSADA;
      case 'BLOQUEADA':
        return StatusConexao.BLOQUEADA;
      default:
        return StatusConexao.PENDENTE;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'atleta_solicitante_id': atletaSolicitanteId,
      'nome_solicitante': nomeSolicitante,
      'foto_solicitante': fotoSolicitante,
      'atleta_destinatario_id': atletaDestinatarioId,
      'nome_destinatario': nomeDestinatario,
      'foto_destinatario': fotoDestinatario,
      'tipo_conexao': tipoConexao.name,
      'status': status.name,
      'mensagem': mensagem,
      'data_solicitacao': dataSolicitacao.toIso8601String(),
      'data_resposta': dataResposta?.toIso8601String(),
      'total_jogos_juntos': totalJogosJuntos,
      'vitorias_solicitante': vitoriasSolicitante,
      'vitorias_destinatario': vitoriasDestinatario,
      'avaliacao_solicitante': avaliacaoSolicitante,
      'avaliacao_destinatario': avaliacaoDestinatario,
      'notificacao_enviada': notificacaoEnviada,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  String get statusTexto {
    switch (status) {
      case StatusConexao.PENDENTE:
        return 'Aguardando resposta';
      case StatusConexao.ACEITA:
        return 'Conectado';
      case StatusConexao.RECUSADA:
        return 'Recusado';
      case StatusConexao.BLOQUEADA:
        return 'Bloqueado';
    }
  }

  String get tipoTexto {
    switch (tipoConexao) {
      case TipoConexao.AMIZADE:
        return 'Amizade';
      case TipoConexao.PARCERIA:
        return 'Parceria';
      case TipoConexao.ADVERSARIO_PREFERIDO:
        return 'Adversário Preferido';
    }
  }

  String get corStatus {
    switch (status) {
      case StatusConexao.PENDENTE:
        return '#FF9800'; // Laranja
      case StatusConexao.ACEITA:
        return '#4CAF50'; // Verde
      case StatusConexao.RECUSADA:
        return '#F44336'; // Vermelho
      case StatusConexao.BLOQUEADA:
        return '#424242'; // Cinza escuro
    }
  }

  bool get isPendente => status == StatusConexao.PENDENTE;
  bool get isAceita => status == StatusConexao.ACEITA;
  bool get isRecusada => status == StatusConexao.RECUSADA;
  bool get isBloqueada => status == StatusConexao.BLOQUEADA;

  bool get isAmizade => tipoConexao == TipoConexao.AMIZADE;
  bool get isParceria => tipoConexao == TipoConexao.PARCERIA;
  bool get isAdversario => tipoConexao == TipoConexao.ADVERSARIO_PREFERIDO;

  bool get temHistoricoJogos =>
      totalJogosJuntos != null && totalJogosJuntos! > 0;

  String get estatisticaJogos {
    if (!temHistoricoJogos) return 'Nenhum jogo registrado';

    if (isParceria) {
      return '$totalJogosJuntos jogos como parceiros';
    } else if (isAdversario) {
      final vitSol = vitoriasSolicitante ?? 0;
      final vitDest = vitoriasDestinatario ?? 0;
      return '$vitSol x $vitDest ($totalJogosJuntos jogos)';
    }

    return '$totalJogosJuntos jogos juntos';
  }

  double? get avaliacaoMedia {
    final avalSol = avaliacaoSolicitante ?? 0;
    final avalDest = avaliacaoDestinatario ?? 0;

    if (avalSol == 0 && avalDest == 0) return null;
    if (avalSol == 0) return avalDest;
    if (avalDest == 0) return avalSol;

    return (avalSol + avalDest) / 2;
  }

  String get tempoSolicitacao {
    final agora = DateTime.now();
    final diferenca = agora.difference(dataSolicitacao);

    if (diferenca.inDays > 0) {
      return '${diferenca.inDays}d atrás';
    } else if (diferenca.inHours > 0) {
      return '${diferenca.inHours}h atrás';
    } else if (diferenca.inMinutes > 0) {
      return '${diferenca.inMinutes}min atrás';
    } else {
      return 'agora';
    }
  }

  ConexaoModel copyWith({
    int? id,
    int? atletaSolicitanteId,
    String? nomeSolicitante,
    String? fotoSolicitante,
    int? atletaDestinatarioId,
    String? nomeDestinatario,
    String? fotoDestinatario,
    TipoConexao? tipoConexao,
    StatusConexao? status,
    String? mensagem,
    DateTime? dataSolicitacao,
    DateTime? dataResposta,
    int? totalJogosJuntos,
    int? vitoriasSolicitante,
    int? vitoriasDestinatario,
    double? avaliacaoSolicitante,
    double? avaliacaoDestinatario,
    bool? notificacaoEnviada,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ConexaoModel(
      id: id ?? this.id,
      atletaSolicitanteId: atletaSolicitanteId ?? this.atletaSolicitanteId,
      nomeSolicitante: nomeSolicitante ?? this.nomeSolicitante,
      fotoSolicitante: fotoSolicitante ?? this.fotoSolicitante,
      atletaDestinatarioId: atletaDestinatarioId ?? this.atletaDestinatarioId,
      nomeDestinatario: nomeDestinatario ?? this.nomeDestinatario,
      fotoDestinatario: fotoDestinatario ?? this.fotoDestinatario,
      tipoConexao: tipoConexao ?? this.tipoConexao,
      status: status ?? this.status,
      mensagem: mensagem ?? this.mensagem,
      dataSolicitacao: dataSolicitacao ?? this.dataSolicitacao,
      dataResposta: dataResposta ?? this.dataResposta,
      totalJogosJuntos: totalJogosJuntos ?? this.totalJogosJuntos,
      vitoriasSolicitante: vitoriasSolicitante ?? this.vitoriasSolicitante,
      vitoriasDestinatario: vitoriasDestinatario ?? this.vitoriasDestinatario,
      avaliacaoSolicitante: avaliacaoSolicitante ?? this.avaliacaoSolicitante,
      avaliacaoDestinatario:
          avaliacaoDestinatario ?? this.avaliacaoDestinatario,
      notificacaoEnviada: notificacaoEnviada ?? this.notificacaoEnviada,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  ConexaoModel aceitar({String? mensagemResposta}) {
    return copyWith(
      status: StatusConexao.ACEITA,
      dataResposta: DateTime.now(),
      mensagem: mensagemResposta ?? mensagem,
      updatedAt: DateTime.now(),
    );
  }

  ConexaoModel recusar({String? mensagemResposta}) {
    return copyWith(
      status: StatusConexao.RECUSADA,
      dataResposta: DateTime.now(),
      mensagem: mensagemResposta ?? mensagem,
      updatedAt: DateTime.now(),
    );
  }

  ConexaoModel bloquear() {
    return copyWith(
      status: StatusConexao.BLOQUEADA,
      dataResposta: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'ConexaoModel(id: $id, solicitante: $nomeSolicitante, destinatario: $nomeDestinatario, tipo: ${tipoConexao.name}, status: ${status.name})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ConexaoModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class SolicitacaoConexaoModel {
  final int atletaDestinatarioId;
  final String nomeDestinatario;
  final TipoConexao tipoConexao;
  final String? mensagem;
  final String? emailConvite; // Para atletas não cadastrados
  final String? whatsappConvite; // Para atletas não cadastrados

  SolicitacaoConexaoModel({
    required this.atletaDestinatarioId,
    required this.nomeDestinatario,
    required this.tipoConexao,
    this.mensagem,
    this.emailConvite,
    this.whatsappConvite,
  });

  Map<String, dynamic> toJson() {
    return {
      'atleta_destinatario_id': atletaDestinatarioId,
      'nome_destinatario': nomeDestinatario,
      'tipo_conexao': tipoConexao.name,
      'mensagem': mensagem,
      'email_convite': emailConvite,
      'whatsapp_convite': whatsappConvite,
    };
  }

  bool get isConviteExterno => emailConvite != null || whatsappConvite != null;
}
