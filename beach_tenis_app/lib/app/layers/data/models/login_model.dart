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

/// Model para Tipo de Sexo
class TipoSexoModel {
  final int id;
  final String nome;
  final String codigo;

  TipoSexoModel({
    required this.id,
    required this.nome,
    required this.codigo,
  });

  factory TipoSexoModel.fromJson(Map<String, dynamic> json) {
    return TipoSexoModel(
      id: json['id'] ?? 0,
      nome: json['nome']?.toString() ?? '',
      codigo: json['codigo']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'codigo': codigo,
    };
  }
}

/// Model para Tipo de Usuário
class TipoUsuarioModel {
  final int id;
  final int tipoUsuarioId;
  final String nomeTipo;
  final String codigoTipo;
  final bool principal;
  final bool ativo;

  TipoUsuarioModel({
    required this.id,
    required this.tipoUsuarioId,
    required this.nomeTipo,
    required this.codigoTipo,
    required this.principal,
    required this.ativo,
  });

  factory TipoUsuarioModel.fromJson(Map<String, dynamic> json) {
    return TipoUsuarioModel(
      id: json['id'] ?? 0,
      tipoUsuarioId: json['tipo_usuario_id'] ?? 0,
      nomeTipo: json['nome_tipo']?.toString() ?? '',
      codigoTipo: json['codigo_tipo']?.toString() ?? '',
      principal: json['principal'] ?? false,
      ativo: json['ativo'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipo_usuario_id': tipoUsuarioId,
      'nome_tipo': nomeTipo,
      'codigo_tipo': codigoTipo,
      'principal': principal,
      'ativo': ativo,
    };
  }
}

/// Model para Endereço
class EnderecoModel {
  final int id;
  final String cep;
  final String logradouro;
  final String numero;
  final String? complemento;
  final String bairro;
  final String cidade;
  final String estado;
  final String pais;
  final bool principal;
  final int tipoEnderecoId;
  final String nomeTipo;
  final bool ativo;

  EnderecoModel({
    required this.id,
    required this.cep,
    required this.logradouro,
    required this.numero,
    this.complemento,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.pais,
    required this.principal,
    required this.tipoEnderecoId,
    required this.nomeTipo,
    required this.ativo,
  });

  factory EnderecoModel.fromJson(Map<String, dynamic> json) {
    return EnderecoModel(
      id: json['id'] ?? 0,
      cep: json['cep']?.toString() ?? '',
      logradouro: json['logradouro']?.toString() ?? '',
      numero: json['numero']?.toString() ?? '',
      complemento: json['complemento']?.toString(),
      bairro: json['bairro']?.toString() ?? '',
      cidade: json['cidade']?.toString() ?? '',
      estado: json['estado']?.toString() ?? '',
      pais: json['pais']?.toString() ?? '',
      principal: json['principal'] ?? false,
      tipoEnderecoId: json['tipo_endereco_id'] ?? 0,
      nomeTipo: json['nome_tipo']?.toString() ?? '',
      ativo: json['ativo'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cep': cep,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'pais': pais,
      'principal': principal,
      'tipo_endereco_id': tipoEnderecoId,
      'nome_tipo': nomeTipo,
      'ativo': ativo,
    };
  }

  /// Getter para endereço completo formatado
  String get enderecoCompleto {
    String endereco = '$logradouro, $numero';
    if (complemento != null && complemento!.isNotEmpty) {
      endereco += ', $complemento';
    }
    endereco += ', $bairro, $cidade - $estado, $pais';
    return endereco;
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
  final int tipoUsuarioId;
  final int tipoSexoId;
  final TipoSexoModel? tipoSexo;
  final bool ativo;
  final DateTime? ultimoLogin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<TipoUsuarioModel> tipos;
  final List<EnderecoModel> enderecos;

  UsuarioModel({
    required this.id,
    required this.nome,
    this.telefone,
    this.telefoneFmt,
    this.instagram,
    this.facebook,
    this.linkedin,
    required this.email,
    required this.tipoUsuarioId,
    required this.tipoSexoId,
    this.tipoSexo,
    required this.ativo,
    this.ultimoLogin,
    this.createdAt,
    this.updatedAt,
    this.tipos = const [],
    this.enderecos = const [],
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    String? telefoneOriginal = json['telefone']?.toString();

    // Parse tipos
    List<TipoUsuarioModel> tiposList = [];
    if (json['tipos'] != null) {
      tiposList = (json['tipos'] as List)
          .map((tipo) => TipoUsuarioModel.fromJson(tipo))
          .toList();
    }

    // Parse endereços
    List<EnderecoModel> enderecosList = [];
    if (json['enderecos'] != null) {
      enderecosList = (json['enderecos'] as List)
          .map((endereco) => EnderecoModel.fromJson(endereco))
          .toList();
    }

    // Parse tipo_sexo
    TipoSexoModel? tipoSexo;
    if (json['tipo_sexo'] != null) {
      tipoSexo = TipoSexoModel.fromJson(json['tipo_sexo']);
    }

    return UsuarioModel(
      id: json['id'] ?? 0,
      nome: json['nome']?.toString() ?? '',
      telefone: telefoneOriginal,
      telefoneFmt: formatTelefone(telefoneOriginal),
      instagram: json['instagram']?.toString(),
      facebook: json['facebook']?.toString(),
      linkedin: json['linkedin']?.toString(),
      email: json['email']?.toString() ?? '',
      tipoUsuarioId: json['tipo_usuario_id'] ?? 0,
      tipoSexoId: json['tipo_sexo_id'] ?? 0,
      tipoSexo: tipoSexo,
      ativo: json['ativo'] ?? false,
      ultimoLogin: json['ultimo_login'] != null ? DateTime.tryParse(json['ultimo_login'].toString()) : null,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'].toString()) : null,
      tipos: tiposList,
      enderecos: enderecosList,
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
      'tipo_usuario_id': tipoUsuarioId,
      'tipo_sexo_id': tipoSexoId,
      'tipo_sexo': tipoSexo?.toJson(),
      'ativo': ativo,
      'ultimo_login': ultimoLogin?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'tipos': tipos.map((tipo) => tipo.toJson()).toList(),
      'enderecos': enderecos.map((endereco) => endereco.toJson()).toList(),
    };
  }

  /// Getter para obter o tipo principal do usuário
  TipoUsuarioModel? get tipoPrincipal {
    try {
      return tipos.firstWhere((tipo) => tipo.principal && tipo.ativo);
    } catch (e) {
      return tipos.isNotEmpty ? tipos.first : null;
    }
  }

  /// Getter para verificar se é aluno
  bool get isAluno => tipoPrincipal?.codigoTipo == 'ALUNO';

  /// Getter para verificar se é professor
  bool get isProfessor => tipoPrincipal?.codigoTipo == 'PROFESSOR';

  /// Getter para verificar se é admin
  bool get isAdmin => tipoPrincipal?.codigoTipo == 'ADMIN';

  /// Getter para verificar se é arena
  bool get isArena => tipoPrincipal?.codigoTipo == 'ARENA';

  /// Getter para verificar se é atleta
  bool get isAtleta => tipoPrincipal?.codigoTipo == 'ATLETA';

  /// Getter para verificar se é profissional técnico
  bool get isProfissionalTecnico => tipoPrincipal?.codigoTipo == 'PROFISSIONAL_TECNICO';

  /// Getter para verificar se tem múltiplos perfis ativos
  bool get hasMultipleProfiles => tipos.where((tipo) => tipo.ativo).length > 1;

  /// Getter para obter todos os tipos ativos
  List<TipoUsuarioModel> get tiposAtivos => tipos.where((tipo) => tipo.ativo).toList();

  /// Getter para obter o endereço principal
  EnderecoModel? get enderecoPrincipal {
    try {
      return enderecos.firstWhere((endereco) => endereco.principal && endereco.ativo);
    } catch (e) {
      return enderecos.isNotEmpty ? enderecos.first : null;
    }
  }

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
    int? tipoUsuarioId,
    int? tipoSexoId,
    TipoSexoModel? tipoSexo,
    bool? ativo,
    DateTime? ultimoLogin,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<TipoUsuarioModel>? tipos,
    List<EnderecoModel>? enderecos,
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
      tipoUsuarioId: tipoUsuarioId ?? this.tipoUsuarioId,
      tipoSexoId: tipoSexoId ?? this.tipoSexoId,
      tipoSexo: tipoSexo ?? this.tipoSexo,
      ativo: ativo ?? this.ativo,
      ultimoLogin: ultimoLogin ?? this.ultimoLogin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tipos: tipos ?? this.tipos,
      enderecos: enderecos ?? this.enderecos,
    );
  }

  @override
  String toString() {
    return 'UsuarioModel(id: $id, nome: $nome, email: $email, tipoPrincipal: ${tipoPrincipal?.codigoTipo})';
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
  String get tipoUsuario => usuario?.tipoPrincipal?.codigoTipo ?? '';

  /// Getter para verificar se tem múltiplos perfis
  bool get hasMultipleProfiles => usuario?.hasMultipleProfiles ?? false;

  /// Getter para obter todos os tipos ativos
  List<TipoUsuarioModel> get tiposAtivos => usuario?.tiposAtivos ?? [];

  /// Getter para verificar se o usuário está ativo
  bool get usuarioAtivo => usuario?.ativo ?? false;

  @override
  String toString() {
    if (hasError) {
      return 'LoginModel(success: false, error: $errorMessage)';
    }
    return 'LoginModel(success: $success, usuario: ${usuario?.nome}, tipo: ${usuario?.tipoPrincipal?.codigoTipo})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginModel && other.success == success && other.token == token && other.usuario == usuario;
  }

  @override
  int get hashCode => success.hashCode ^ token.hashCode ^ usuario.hashCode;
}
