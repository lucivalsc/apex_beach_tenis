///
/// Model para Professor - Beach Tênis App
///

class ProfessorModel {
  final int id;
  final String nome;
  final String cpf;
  final String email;
  final String? telefone;
  final String? telefoneFmt;
  final String? instagram;
  final String? facebook;
  final DateTime? dataNascimento;
  final String? especialidade;
  final bool ativo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int usuarioId;
  final List<int> arenasIds; // IDs das arenas onde o professor trabalha

  ProfessorModel({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.email,
    this.telefone,
    this.telefoneFmt,
    this.instagram,
    this.facebook,
    this.dataNascimento,
    this.especialidade,
    required this.ativo,
    this.createdAt,
    this.updatedAt,
    required this.usuarioId,
    this.arenasIds = const [],
  });

  factory ProfessorModel.fromJson(Map<String, dynamic> json) {
    String? telefoneOriginal = json['telefone']?.toString();
    
    return ProfessorModel(
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
      especialidade: json['especialidade']?.toString(),
      ativo: json['ativo'] ?? true,
      createdAt: json['createdAt'] != null 
          ? DateTime.tryParse(json['createdAt'].toString()) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.tryParse(json['updatedAt'].toString()) 
          : null,
      usuarioId: json['usuario_id'] ?? 0,
      arenasIds: json['arenas_ids'] != null 
          ? List<int>.from(json['arenas_ids']) 
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
      'especialidade': especialidade,
      'ativo': ativo,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'usuario_id': usuarioId,
      'arenas_ids': arenasIds,
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
    return 'P';
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

  /// Getter para CPF formatado
  String get cpfFormatado {
    if (cpf.length != 11) return cpf;
    return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9)}';
  }

  /// Getter para telefone formatado
  String get telefoneFormatado {
    return telefoneFmt ?? telefone ?? '';
  }

  /// Getter para foto (placeholder por enquanto)
  String? get foto => null;

  /// Getter para alunosIds (compatibilidade com código antigo)
  List<int> get alunosIds => [];

  /// Copia o professor com novos valores
  ProfessorModel copyWith({
    int? id,
    String? nome,
    String? cpf,
    String? email,
    String? telefone,
    String? instagram,
    String? facebook,
    DateTime? dataNascimento,
    String? especialidade,
    bool? ativo,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? usuarioId,
    List<int>? arenasIds,
  }) {
    return ProfessorModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      telefoneFmt: telefone != null ? _formatTelefone(telefone) : telefoneFmt,
      instagram: instagram ?? this.instagram,
      facebook: facebook ?? this.facebook,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      especialidade: especialidade ?? this.especialidade,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      usuarioId: usuarioId ?? this.usuarioId,
      arenasIds: arenasIds ?? this.arenasIds,
    );
  }

  @override
  String toString() {
    return 'ProfessorModel(id: $id, nome: $nome, email: $email, ativo: $ativo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProfessorModel && 
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