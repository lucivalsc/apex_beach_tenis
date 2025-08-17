///
/// Model para Beach Tênis App - Login Response
///

/// Função utilitária para formatar telefone
String formatTelefone(String? telefone) {
  if (telefone == null || telefone.isEmpty) return '';

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

/// Enum para tipos de usuário
enum TipoUsuario { ALUNO, PROFESSOR, ADMIN, CONVIDADO }

extension TipoUsuarioExtension on TipoUsuario {
  String get value {
    switch (this) {
      case TipoUsuario.ALUNO:
        return 'ALUNO';
      case TipoUsuario.PROFESSOR:
        return 'PROFESSOR';
      case TipoUsuario.ADMIN:
        return 'ADMIN';
      case TipoUsuario.CONVIDADO:
        return 'CONVIDADO';
    }
  }

  static TipoUsuario fromString(String tipo) {
    switch (tipo.toUpperCase()) {
      case 'ALUNO':
        return TipoUsuario.ALUNO;
      case 'PROFESSOR':
        return TipoUsuario.PROFESSOR;
      case 'ADMIN':
        return TipoUsuario.ADMIN;
      case 'CONVIDADO':
        return TipoUsuario.CONVIDADO;
      default:
        return TipoUsuario.ALUNO; // Default
    }
  }
}

/// Model do Usuário
class UsuarioModel {
  final int id;
  final String nome;
  final String? telefone;
  final String? telefoneFmt; // Telefone formatado
  final String? instagram;
  final String? facebook;
  final String? linkedin;
  final String email;
  final TipoUsuario tipo;
  final bool ativo;
  final DateTime? ultimoLogin;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UsuarioModel({
    required this.id,
    required this.nome,
    this.telefone,
    this.telefoneFmt,
    this.instagram,
    this.facebook,
    this.linkedin,
    required this.email,
    required this.tipo,
    required this.ativo,
    this.ultimoLogin,
    this.createdAt,
    this.updatedAt,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    String? telefoneOriginal = json['telefone']?.toString();

    return UsuarioModel(
      id: json['id'] ?? 0,
      nome: json['nome']?.toString() ?? '',
      telefone: telefoneOriginal,
      telefoneFmt: formatTelefone(telefoneOriginal),
      instagram: json['instagram']?.toString(),
      facebook: json['facebook']?.toString(),
      linkedin: json['linkedin']?.toString(),
      email: json['email']?.toString() ?? '',
      tipo: TipoUsuarioExtension.fromString(json['tipo']?.toString() ?? 'ALUNO'),
      ativo: json['ativo'] ?? false,
      ultimoLogin: json['ultimo_login'] != null ? DateTime.tryParse(json['ultimo_login'].toString()) : null,
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at'].toString()) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'instagram': instagram,
      'facebook': facebook,
      'linkedin': linkedin,
      'email': email,
      'tipo': tipo.value,
      'ativo': ativo,
      'ultimo_login': ultimoLogin?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  /// Getter para verificar se é aluno
  bool get isAluno => tipo == TipoUsuario.ALUNO;

  /// Getter para verificar se é professor
  bool get isProfessor => tipo == TipoUsuario.PROFESSOR;

  /// Getter para verificar se é admin
  bool get isAdmin => tipo == TipoUsuario.ADMIN;

  /// Getter para nome de exibição (primeiro nome + sobrenome)
  String get nomeExibicao {
    List<String> partes = nome.split(' ');
    if (partes.length > 1) {
      return '${partes.first} ${partes.last}';
    }
    return nome;
  }

  /// Getter para iniciais do nome
  String get iniciais {
    List<String> partes = nome.split(' ');
    if (partes.length >= 2) {
      return '${partes.first[0]}${partes.last[0]}'.toUpperCase();
    } else if (partes.isNotEmpty) {
      return partes.first.substring(0, 1).toUpperCase();
    }
    return 'U';
  }

  /// Verifica se tem redes sociais configuradas
  bool get temRedesSociais {
    return instagram != null || facebook != null || linkedin != null;
  }

  /// Copia o usuário com novos valores
  UsuarioModel copyWith({
    int? id,
    String? nome,
    String? telefone,
    String? instagram,
    String? facebook,
    String? linkedin,
    String? email,
    TipoUsuario? tipo,
    bool? ativo,
    DateTime? ultimoLogin,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UsuarioModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
      telefoneFmt: telefone != null ? formatTelefone(telefone) : telefoneFmt,
      instagram: instagram ?? this.instagram,
      facebook: facebook ?? this.facebook,
      linkedin: linkedin ?? this.linkedin,
      email: email ?? this.email,
      tipo: tipo ?? this.tipo,
      ativo: ativo ?? this.ativo,
      ultimoLogin: ultimoLogin ?? this.ultimoLogin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'UsuarioModel(id: $id, nome: $nome, email: $email, tipo: ${tipo.value})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UsuarioModel && other.id == id && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}

/// Model principal de resposta do login
class LoginModel {
  final bool success;
  final String? token;
  final UsuarioModel? usuario;
  final String? errorMessage; // Para casos de erro

  LoginModel({
    required this.success,
    this.token,
    this.usuario,
    this.errorMessage,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json['success'] ?? false,
      token: json['token']?.toString(),
      usuario: json['usuario'] != null ? UsuarioModel.fromJson(json['usuario']) : null,
      errorMessage: json['message']?.toString() ?? json['error']?.toString(),
    );
  }

  /// Factory para resposta de erro
  factory LoginModel.error(String message) {
    return LoginModel(
      success: false,
      errorMessage: message,
    );
  }

  /// Factory para resposta de sucesso
  factory LoginModel.success({
    required String token,
    required UsuarioModel usuario,
  }) {
    return LoginModel(
      success: true,
      token: token,
      usuario: usuario,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    if (token != null) data['token'] = token;
    if (usuario != null) data['usuario'] = usuario!.toJson();
    if (errorMessage != null) data['message'] = errorMessage;
    return data;
  }

  /// Verifica se o login foi bem-sucedido e tem dados válidos
  bool get isValid => success && token != null && usuario != null;

  /// Verifica se é um erro
  bool get hasError => !success || errorMessage != null;

  /// Getter para o nome do usuário (seguro)
  String get nomeUsuario => usuario?.nome ?? '';

  /// Getter para o email do usuário (seguro)
  String get emailUsuario => usuario?.email ?? '';

  /// Getter para o tipo do usuário (seguro)
  String get tipoUsuario => usuario?.tipo.value ?? '';

  /// Getter para verificar se o usuário está ativo
  bool get usuarioAtivo => usuario?.ativo ?? false;

  @override
  String toString() {
    if (hasError) {
      return 'LoginModel(success: false, error: $errorMessage)';
    }
    return 'LoginModel(success: $success, usuario: ${usuario?.nome}, tipo: ${usuario?.tipo.value})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginModel && other.success == success && other.token == token && other.usuario == usuario;
  }

  @override
  int get hashCode => success.hashCode ^ token.hashCode ^ usuario.hashCode;
}
