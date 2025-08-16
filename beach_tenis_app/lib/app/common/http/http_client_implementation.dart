import "dart:async";
import "dart:convert";
import "package:http/http.dart";
import "package:http/http.dart" as http;
import "../models/exception_models.dart";
import "http_client.dart";

class HttpClientImplementation implements IHttpClient {
  final client = http.Client();
  late Response response;

  @override
  Future<HttpResponse> get({required String url, Map<String, String>? headers}) async {
    try {
      response = await client.get(Uri.parse(url), headers: headers).timeout(const Duration(seconds: 30));
      return HttpResponse(
        statusCode: response.statusCode,
        data: json.decode(
          response.body,
        ),
      );
    } on TimeoutException {
      throw const ServerException(
        message: 'Timeout ao tentar conectar ao servidor.',
        title: 'Timeout',
        statusCode: -1,
      );
    } on FormatException catch (e) {
      // Captura a exceção FormatException e passa a mensagem de erro para o ServerException
      throw ServerException(
        statusCode: response.statusCode,
        message: e.source,
        title: 'Erro de formatação',
      );
    } catch (e) {
      // Captura outras exceções e passa a mensagem de erro para o ServerException
      throw ServerException(
        message: e.toString(),
        title: 'Erro',
        statusCode: -1,
      );
    }
  }

  @override
  Future<HttpResponse> post({required String url, Map<String, String>? headers, Map<String, dynamic>? payload}) async {
    try {
      response = await client
          .post(
            Uri.parse(url),
            headers: headers,
            body: payload != null ? json.encode(payload) : null,
          )
          .timeout(const Duration(seconds: 30));
      return HttpResponse(
        statusCode: response.statusCode,
        data: json.decode(response.body),
      );
    } on TimeoutException {
      throw const ServerException(
        message: 'Timeout ao tentar conectar ao servidor.',
        title: 'Timeout',
        statusCode: -1,
      );
    } on FormatException catch (e) {
      // Captura a exceção FormatException e passa a mensagem de erro para o ServerException
      throw ServerException(
        statusCode: response.statusCode,
        message: e.source,
        title: 'Erro de formatação',
      );
    } catch (e) {
      // Captura outras exceções e passa a mensagem de erro para o ServerException
      throw ServerException(
        message: e.toString(),
        title: 'Erro',
        statusCode: -1,
      );
    }
  }

  @override
  Future<HttpResponse> post2({required String url, Map<String, String>? headers, Map<String, dynamic>? payload}) async {
    try {
      response = await client
          .post(
            Uri.parse(url),
            headers: headers,
            body: payload != null ? json.encode(payload) : null,
          )
          .timeout(const Duration(seconds: 30));
      return HttpResponse(
        statusCode: response.statusCode,
        data: null,
      );
    } on TimeoutException {
      throw const ServerException(
        message: 'Timeout ao tentar conectar ao servidor.',
        title: 'Timeout',
        statusCode: -1,
      );
    } on FormatException catch (e) {
      // Captura a exceção FormatException e passa a mensagem de erro para o ServerException
      throw ServerException(
        statusCode: response.statusCode,
        message: e.source,
        title: 'Erro de formatação',
      );
    } catch (e) {
      // Captura outras exceções e passa a mensagem de erro para o ServerException
      throw ServerException(
        message: e.toString(),
        title: 'Erro',
        statusCode: -1,
      );
    }
  }

  @override
  Future<HttpResponse> patch({required String url, Map<String, String>? headers, Map<String, dynamic>? payload}) async {
    try {
      response = await client
          .patch(
            Uri.parse(url),
            headers: headers,
            body: payload != null ? json.encode(payload) : null,
          )
          .timeout(const Duration(seconds: 30));
      return HttpResponse(
        statusCode: response.statusCode,
        data: json.decode(
          response.body,
        ),
      );
    } on TimeoutException {
      throw const ServerException(
        message: 'Timeout ao tentar conectar ao servidor.',
        title: 'Timeout',
        statusCode: -1,
      );
    } on FormatException catch (e) {
      // Captura a exceção FormatException e passa a mensagem de erro para o ServerException
      throw ServerException(
        statusCode: response.statusCode,
        message: e.source,
        title: 'Erro de formatação',
      );
    } catch (e) {
      // Captura outras exceções e passa a mensagem de erro para o ServerException
      throw ServerException(
        message: e.toString(),
        title: 'Erro',
        statusCode: -1,
      );
    }
  }
}
