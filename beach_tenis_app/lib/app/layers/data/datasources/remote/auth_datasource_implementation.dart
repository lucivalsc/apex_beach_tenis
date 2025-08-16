import 'package:beach_tenis_app/app/common/models/exception_models.dart';

import '../../../../common/http/http_client.dart';
import 'auth_datasource.dart';

class AuthDatasourceImplementation implements IAuthDatasource {
  final Map<String, String> headers = {"Content-Type": "application/json"};
  final IHttpClient client;

  AuthDatasourceImplementation(this.client);

  // Mock de usuários para teste
  final Map<String, Map<String, dynamic>> _mockUsers = {
    'tentante@fertilink.com': {
      'senha': '123456',
      'tipo': 'tentante',
      'dados': {
        'id': 1,
        'nome': 'Maria Silva',
        'email': 'tentante@fertilink.com',
        'tipo_usuario': 'tentante',
        'idade': 32,
        'cidade': 'São Paulo',
        'estado': 'SP',
        'telefone': '(11) 99999-1111',
        'token': 'mock_token_tentante_123',
        'perfil_completo': true,
        'data_cadastro': '2024-01-15',
        'preferencias': {
          'tipo_doacao': 'espermatozoide',
          'idade_doador_min': 25,
          'idade_doador_max': 40,
          'localidade_preferida': 'São Paulo'
        }
      }
    },
    'doador@fertilink.com': {
      'senha': '123456',
      'tipo': 'doador',
      'dados': {
        'id': 2,
        'nome': 'João Santos',
        'email': 'doador@fertilink.com',
        'tipo_usuario': 'doador',
        'idade': 28,
        'cidade': 'Rio de Janeiro',
        'estado': 'RJ',
        'telefone': '(21) 99999-2222',
        'token': 'mock_token_doador_456',
        'perfil_completo': true,
        'data_cadastro': '2024-02-10',
        'tipo_doacao': 'espermatozoide',
        'disponibilidade': true,
        'exames_atualizados': true,
        'ultima_doacao': '2024-06-15',
        'avaliacoes': {'media': 4.8, 'total': 12}
      }
    }
  };

  @override
  Future<List<Object>> signIn(List<Object> object) async {
    var username = object[0] as String;
    var password = object[1] as String;
    // var resource = object[3] as String; // Não usado no mock

    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      // Verifica se o usuário existe no mock
      if (_mockUsers.containsKey(username)) {
        var userData = _mockUsers[username]!;

        // Verifica a senha
        if (userData['senha'] == password) {
          // Login bem-sucedido - retorna os dados do usuário
          return [
            {
              'success': true,
              'message': 'Login realizado com sucesso',
              'user': userData['dados'],
              'timestamp': DateTime.now().toIso8601String()
            }
          ];
        } else {
          // Senha incorreta
          throw const ServerException(
              statusCode: 401,
              title: 'Falha de Autenticação',
              message: 'Senha incorreta. Verifique suas credenciais e tente novamente.');
        }
      } else {
        // Usuário não encontrado
        throw const ServerException(
            statusCode: 404,
            title: 'Usuário não encontrado',
            message: 'Email não cadastrado. Verifique o email ou crie uma nova conta.');
      }
    } catch (e) {
      // Se for uma ServerException, relança
      if (e is ServerException) {
        rethrow;
      }

      // Para outros erros, cria uma ServerException genérica
      throw const ServerException(
          statusCode: 500, title: 'Erro interno', message: 'Ocorreu um erro inesperado. Tente novamente mais tarde.');
    }
  }

  void login(String username, String password) {}
}
