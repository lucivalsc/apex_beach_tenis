///
/// Model para Arena - Beach Tênis App
///

class ArenaModel {
  final int id;
  final String nome;
  final String cnpj;
  final String email;
  final String? telefone;
  final String? telefoneFmt;
  final String? whatsapp;
  final String? instagram;
  final String? facebook;
  final String? endereco;
  final String? cep;
  final String? cidade;
  final String? estado;
  final double? latitude;
  final double? longitude;
  final String? descricao;
  final int? quantidadeQuadras;
  final String? horarioFuncionamento;
  final String statusAssinatura; // ATIVO, INATIVO, VENCIDO
  final DateTime? dataVencimento;
  final String? tipoAssinatura; // MENSAL, TRIMESTRAL, SEMESTRAL, ANUAL
  final bool ativo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int usuarioId;
  final List<int> professoresIds;
  final List<int> alunosIds;

  ArenaModel({
    required this.id,
    required this.nome,
    required this.cnpj,
    required this.email,
    this.telefone,
    this.telefoneFmt,
    this.whatsapp,
    this.instagram,
    this.facebook,
    this.endereco,
    this.cep,
    this.cidade,
    this.estado,
    this.latitude,
    this.longitude,
    this.descricao,
    this.quantidadeQuadras,
    this.horarioFuncionamento,
    required this.statusAssinatura,
    this.dataVencimento,
    this.tipoAssinatura,
    required this.ativo,
    this.createdAt,
    this.updatedAt,
    required this.usuarioId,
    this.professoresIds = const [],
    this.alunosIds = const [],
  });

  factory ArenaModel.fromJson(Map<String, dynamic> json) {
    String? telefoneOriginal = json['telefone']?.toString();
    
    return ArenaModel(
      id: json['id'] ?? 0,
      nome: json['nome']?.toString() ?? '',
      cnpj: json['cnpj']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      telefone: telefoneOriginal,
      telefoneFmt: _formatTelefone(telefoneOriginal),
      whatsapp: json['whatsapp']?.toString(),
      instagram: json['instagram']?.toString(),
      facebook: json['facebook']?.toString(),
      endereco: json['endereco']?.toString(),
      cep: json['cep']?.toString(),
      cidade: json['cidade']?.toString(),
      estado: json['estado']?.toString(),
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      descricao: json['descricao']?.toString(),
      quantidadeQuadras: json['quantidade_quadras'] ?? 0,
      horarioFuncionamento: json['horario_funcionamento']?.toString(),
      statusAssinatura: json['status_assinatura']?.toString() ?? 'ATIVO',
      dataVencimento: json['data_vencimento'] != null 
          ? DateTime.tryParse(json['data_vencimento'].toString()) 
          : null,
      tipoAssinatura: json['tipo_assinatura']?.toString(),
      ativo: json['ativo'] ?? true,
      createdAt: json['createdAt'] != null 
          ? DateTime.tryParse(json['createdAt'].toString()) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.tryParse(json['updatedAt'].toString()) 
          : null,
      usuarioId: json['usuario_id'] ?? 0,
      professoresIds: json['professores_ids'] != null 
          ? List<int>.from(json['professores_ids']) 
          : [],
      alunosIds: json['alunos_ids'] != null 
          ? List<int>.from(json['alunos_ids']) 
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cnpj': cnpj,
      'email': email,
      'telefone': telefone,
      'whatsapp': whatsapp,
      'instagram': instagram,
      'facebook': facebook,
      'endereco': endereco,
      'cep': cep,
      'cidade': cidade,
      'estado': estado,
      'latitude': latitude,
      'longitude': longitude,
      'descricao': descricao,
      'quantidade_quadras': quantidadeQuadras,
      'horario_funcionamento': horarioFuncionamento,
      'status_assinatura': statusAssinatura,
      'data_vencimento': dataVencimento?.toIso8601String(),
      'tipo_assinatura': tipoAssinatura,
      'ativo': ativo,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'usuario_id': usuarioId,
      'professores_ids': professoresIds,
      'alunos_ids': alunosIds,
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

  /// Getter para endereço completo
  String get enderecoCompleto {
    List<String> partes = [];
    if (endereco != null && endereco!.isNotEmpty) partes.add(endereco!);
    if (cidade != null && cidade!.isNotEmpty) partes.add(cidade!);
    if (estado != null && estado!.isNotEmpty) partes.add(estado!);
    if (cep != null && cep!.isNotEmpty) partes.add('CEP: $cep');
    return partes.join(', ');
  }

  /// Verifica se tem redes sociais configuradas
  bool get temRedesSociais {
    return instagram != null || facebook != null;
  }

  /// Verifica se tem WhatsApp
  bool get temWhatsApp => whatsapp != null && whatsapp!.isNotEmpty;

  /// Getter para cor do status da assinatura
  String get corStatusAssinatura {
    switch (statusAssinatura.toUpperCase()) {
      case 'ATIVO':
        return '#4CAF50'; // Verde
      case 'VENCIDO':
        return '#F44336'; // Vermelho
      case 'INATIVO':
        return '#9E9E9E'; // Cinza
      default:
        return '#FF9800'; // Laranja
    }
  }

  /// Verifica se a assinatura está vencida
  bool get assinaturaVencida {
    if (dataVencimento == null) return false;
    return DateTime.now().isAfter(dataVencimento!);
  }

  /// Dias até o vencimento
  int? get diasParaVencimento {
    if (dataVencimento == null) return null;
    final hoje = DateTime.now();
    return dataVencimento!.difference(hoje).inDays;
  }

  /// Quantidade total de professores
  int get quantidadeProfessores => professoresIds.length;

  /// Quantidade total de alunos
  int get quantidadeAlunos => alunosIds.length;

  /// Verifica se tem localização
  bool get temLocalizacao => latitude != null && longitude != null;

  /// Getter para verificar se pagamento está em dia
  bool get isPagamentoEmDia {
    if (statusAssinatura.toUpperCase() == 'ATIVO') return true;
    if (dataVencimento == null) return true;
    return DateTime.now().isBefore(dataVencimento!);
  }

  /// Copia a arena com novos valores
  ArenaModel copyWith({
    int? id,
    String? nome,
    String? cnpj,
    String? email,
    String? telefone,
    String? whatsapp,
    String? instagram,
    String? facebook,
    String? endereco,
    String? cep,
    String? cidade,
    String? estado,
    double? latitude,
    double? longitude,
    String? descricao,
    int? quantidadeQuadras,
    String? horarioFuncionamento,
    String? statusAssinatura,
    DateTime? dataVencimento,
    String? tipoAssinatura,
    bool? ativo,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? usuarioId,
    List<int>? professoresIds,
    List<int>? alunosIds,
  }) {
    return ArenaModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      cnpj: cnpj ?? this.cnpj,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      telefoneFmt: telefone != null ? _formatTelefone(telefone) : telefoneFmt,
      whatsapp: whatsapp ?? this.whatsapp,
      instagram: instagram ?? this.instagram,
      facebook: facebook ?? this.facebook,
      endereco: endereco ?? this.endereco,
      cep: cep ?? this.cep,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      descricao: descricao ?? this.descricao,
      quantidadeQuadras: quantidadeQuadras ?? this.quantidadeQuadras,
      horarioFuncionamento: horarioFuncionamento ?? this.horarioFuncionamento,
      statusAssinatura: statusAssinatura ?? this.statusAssinatura,
      dataVencimento: dataVencimento ?? this.dataVencimento,
      tipoAssinatura: tipoAssinatura ?? this.tipoAssinatura,
      ativo: ativo ?? this.ativo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      usuarioId: usuarioId ?? this.usuarioId,
      professoresIds: professoresIds ?? this.professoresIds,
      alunosIds: alunosIds ?? this.alunosIds,
    );
  }

  @override
  String toString() {
    return 'ArenaModel(id: $id, nome: $nome, email: $email, status: $statusAssinatura, ativo: $ativo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ArenaModel && 
           other.id == id && 
           other.cnpj == cnpj;
  }

  @override
  int get hashCode => id.hashCode ^ cnpj.hashCode;
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