///
/// Model para Atleta - Beach Tênis App
///

class AtletaModel {
  final int id;
  final String nome;
  final String cpf;
  final String email;
  final String? telefone;
  final String? telefoneFmt;
  final String? instagram;
  final String? facebook;
  final DateTime? dataNascimento;
  final String? nivel; // Iniciante, Intermediário, Avançado, Profissional
  final int? pontuacao;
  final int? ranking;
  final bool ativo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int usuarioId;
  final List<int> amigosIds; // IDs dos amigos/conexões

  AtletaModel({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.email,
    this.telefone,
    this.telefoneFmt,
    this.instagram,
    this.facebook,
    this.dataNascimento,
    this.nivel,
    this.pontuacao,
    this.ranking,
    required this.ativo,
    this.createdAt,
    this.updatedAt,
    required this.usuarioId,
    this.amigosIds = const [],
  });

  factory AtletaModel.fromJson(Map<String, dynamic> json) {
    String? telefoneOriginal = json['telefone']?.toString();
    
    return AtletaModel(
      id: json['id'] ?? 0,
      nome: json['nome']?.toString() ?? '',
      cpf: json['cpf']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      telefone: telefoneOriginal,
      telefoneFmt: _formatTelefone(telefoneOriginal),
      instagram: json['instagram']?.toString(),
      facebook: json['facebook']?.toString(),
      dataNascimento: json['data_nascimento'] != null 
          ? DateTime.tryParse(json['data_nascimento'].toString()) 
          : null,
      nivel: json['nivel']?.toString(),
      pontuacao: json['pontuacao'] ?? 0,
      ranking: json['ranking'],
      ativo: json['ativo'] ?? true,
      createdAt: json['createdAt'] != null 
          ? DateTime.tryParse(json['createdAt'].toString()) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.tryParse(json['updatedAt'].toString()) 
          : null,
      usuarioId: json['usuario_id'] ?? 0,
      amigosIds: json['amigos_ids'] != null 
          ? List<int>.from(json['amigos_ids']) 
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'telefone': telefone,
      'instagram': instagram,
      'facebook': facebook,
      'data_nascimento': dataNascimento?.toIso8601String(),
      'nivel': nivel,
      'pontuacao': pontuacao,
      'ranking': ranking,
      'ativo': ativo,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'usuario_id': usuarioId,
      'amigos_ids': amigosIds,
    };
  }

  /// Getter para iniciais do nome
  String get iniciais {
    List<String> partes = nome.split(' ');
    if (partes.length >= 2) {
      return '${partes.first[0]}${partes.last[0]}'.toUpperCase();
    } else if (partes.isNotEmpty) {
      return partes.first.substring(0, 1).toUpperCase();
    }
    return 'A';
  }

  /// Getter para nome de exibição (primeiro + último nome)
  String get nomeExibicao {
    List<String> partes = nome.split(' ');
    if (partes.length > 1) {
      return '${partes.first} ${partes.last}';
    }
    return nome;
  }

  /// Getter para idade
  int? get idade {
    if (dataNascimento == null) return null;
    final hoje = DateTime.now();
    int idade = hoje.year - dataNascimento!.year;
    if (hoje.month < dataNascimento!.month || 
        (hoje.month == dataNascimento!.month && hoje.day < dataNascimento!.day)) {
      idade--;
    }
    return idade;
  }

  /// Verifica se tem redes sociais configuradas
  bool get temRedesSociais {
    return instagram != null || facebook != null;
  }

  /// Getter para cor do nível
  String get corNivel {
    switch (nivel?.toLowerCase()) {
      case 'iniciante':
        return '#4CAF50'; // Verde
      case 'intermediário':
      case 'intermediario':
        return '#FF9800'; // Laranja
      case 'avançado':
      case 'avancado':
        return '#F44336'; // Vermelho
      case 'profissional':
        return '#9C27B0'; // Roxo
      default:
        return '#9E9E9E'; // Cinza
    }
  }

  /// Getter para ranking formatado
  String get rankingFormatado {
    if (ranking == null) return 'N/A';
    return '#$ranking';
  }

  /// Verifica se tem amigos
  bool get temAmigos => amigosIds.isNotEmpty;

  /// Quantidade de amigos
  int get quantidadeAmigos => amigosIds.length;

  /// Copia o atleta com novos valores
  AtletaModel copyWith({
    int? id,
    String? nome,
    String? cpf,
    String? email,
    String? telefone,
    String? instagram,
    String? facebook,
    DateTime? dataNascimento,
    String? nivel,
    int? pontuacao,
    int? ranking,
    bool? ativo,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? usuarioId,
    List<int>? amigosIds,
  }) {
    return AtletaModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      telefoneFmt: telefone != null ? _formatTelefone(telefone) : telefoneFmt,
      instagram: instagram ?? this.instagram,
      facebook: facebook ?? this.facebook,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      nivel: nivel ?? this.nivel,
      pontuacao: pontuacao ?? this.pontuacao,
      ranking: ranking ?? this.ranking,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      usuarioId: usuarioId ?? this.usuarioId,
      amigosIds: amigosIds ?? this.amigosIds,
    );
  }

  @override
  String toString() {
    return 'AtletaModel(id: $id, nome: $nome, email: $email, nivel: $nivel, ranking: $ranking, ativo: $ativo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AtletaModel && 
           other.id == id && 
           other.cpf == cpf;
  }

  @override
  int get hashCode => id.hashCode ^ cpf.hashCode;
}

/// Função utilitária para formatar telefone
String? _formatTelefone(String? telefone) {
  if (telefone == null || telefone.isEmpty) return null;

  // Remove caracteres não numéricos
  String numeros = telefone.replaceAll(RegExp(r'\D'), '');

  // Se tem 11 dígitos (com DDD e 9 no celular)
  if (numeros.length == 11) {
    return "(${numeros.substring(0, 2)}) ${numeros.substring(2, 3)} ${numeros.substring(3, 7)}-${numeros.substring(7)}";
  }
  // Se tem 10 dígitos (com DDD sem 9)
  else if (numeros.length == 10) {
    return "(${numeros.substring(0, 2)}) ${numeros.substring(2, 6)}-${numeros.substring(6)}";
  }

  return telefone; // Retorna original se não conseguir formatar
}