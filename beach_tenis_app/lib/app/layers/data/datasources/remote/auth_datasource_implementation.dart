import 'package:apex_sports/app/common/models/exception_models.dart';

import '../../../../common/http/http_client.dart';
import 'auth_datasource.dart';

class AuthDatasourceImplementation implements IAuthDatasource {
  final Map<String, String> headers = {"Content-Type": "application/json"};
  final IHttpClient client;

  static const String baseUrl = String.fromEnvironment('DEFINE_API_ADDRESS');
  AuthDatasourceImplementation(this.client);

  @override
  Future<List<Object>> signIn(List<Object> object) async {
    var username = object[0] as String;
    var password = object[1] as String;
    // var baseUrl = object[2] as String;

    try {
      final response = await client.post(
        url: '$baseUrl/auth/login',
        headers: Map.from(headers),
        payload: {"email": username, "senha": password},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return [response.data];
      } else {
        throw ServerException(
          statusCode: response.statusCode,
          message: 'Erro ao autenticar usuário',
        );
      }
    } catch (e) {
      // Para outros erros, cria uma ServerException genérica
      throw const ServerException(
        statusCode: 500,
        title: 'Erro interno',
        message: 'Ocorreu um erro inesperado. Tente novamente mais tarde.',
      );
    }
  }
}
