import 'dart:async';
import 'dart:convert';

import 'package:beach_tenis_app/app/layers/data/models/login_model.dart';
import 'package:beach_tenis_app/app/layers/domain/entities/chat_message_entity.dart';
import 'package:beach_tenis_app/app/layers/domain/entities/donor_profile_entity.dart';
import 'package:beach_tenis_app/app/layers/domain/entities/match_entity.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/chat/chat_usecases.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/data/datas_usecase.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/data/get_sync_datas.dart';
// Importações específicas do Fertilink
import 'package:beach_tenis_app/app/layers/domain/usecases/donor/get_donors_usecase.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/match/match_usecases.dart';
import 'package:beach_tenis_app/app/layers/domain/usecases/user/user_profile_usecases.dart';
import 'package:beach_tenis_app/app/layers/presenter/providers/auth_provider.dart';
import 'package:beach_tenis_app/app/layers/presenter/providers/config_provider.dart';
import 'package:beach_tenis_app/app/layers/presenter/providers/user_provider.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  final DatasUsecase _datasUsecase;
  final GetSyncDatasUsecase _getSyncDatasUsecase;

  // Casos de uso específicos do Fertilink
  final GetAvailableDonorsUseCase? _getAvailableDonorsUseCase;
  final SearchDonorsUseCase? _searchDonorsUseCase;
  final CreateMatchUseCase? _createMatchUseCase;
  final GetMatchesUseCase? _getMatchesUseCase;
  final GetUserProfileUseCase? _getUserProfileUseCase;
  final SendMessageUseCase? _sendMessageUseCase;
  final GetChatMessagesUseCase? _getChatMessagesUseCase;

  DataProvider(
    this._datasUsecase,
    this._getSyncDatasUsecase, {
    // Casos de uso opcionais do Fertilink
    GetAvailableDonorsUseCase? getAvailableDonorsUseCase,
    SearchDonorsUseCase? searchDonorsUseCase,
    CreateMatchUseCase? createMatchUseCase,
    GetMatchesUseCase? getMatchesUseCase,
    GetUserProfileUseCase? getUserProfileUseCase,
    SendMessageUseCase? sendMessageUseCase,
    GetChatMessagesUseCase? getChatMessagesUseCase,
  })  : _getAvailableDonorsUseCase = getAvailableDonorsUseCase,
        _searchDonorsUseCase = searchDonorsUseCase,
        _createMatchUseCase = createMatchUseCase,
        _getMatchesUseCase = getMatchesUseCase,
        _getUserProfileUseCase = getUserProfileUseCase,
        _sendMessageUseCase = sendMessageUseCase,
        _getChatMessagesUseCase = getChatMessagesUseCase;

  late ConfigProvider _configProvider;
  late UserProvider userProvider;
  late AuthProvider authProvider;
  late LoginModelEmpresas empresa;
  void setConfigProvider(ConfigProvider provider) => _configProvider = provider;
  void setUserProvider(UserProvider provider) => userProvider = provider;
  void setAuthProvider(AuthProvider provider) => authProvider = provider;

  Future<Map<String, dynamic>?> datas(
    String datain,
    String datafin,
    String rota, [
    int? ano,
  ]) async {
    var userLogger = await _configProvider.loadLastLoggedEmail();
    var passwordLogger = await _configProvider.loadLastLoggedPassword();
    var branch = await _configProvider.loadCompany();
    final result = await _datasUsecase([
      userLogger,
      passwordLogger,
      datain,
      datafin,
      branch,
      rota,
      ano ?? -1,
    ]);
    return result.fold(
      (l) => null,
      (r) => r[0] as Map<String, dynamic>,
    );
  }

  Future<dynamic> getSyncDatas(String route, Map<String, dynamic> payload) async {
    // static const resource = 'http://192.168.1.106:3000';
    var configuracao = await _configProvider.loadConfig();
    var data = jsonDecode(configuracao);
    var host = data['ip'] ?? '';
    var port = data['port'] ?? '';

    ///
    final result = await _getSyncDatasUsecase([
      route,
      payload,
      'http://$host:$port',
    ]);
    return result.fold(
      (l) => null,
      (r) => r[0],
    );
  }

  void notify() {
    notifyListeners();
  }

  // ========== Métodos específicos do Fertilink ==========

  /// Busca doadores disponíveis para a tela Home Demandante
  Future<List<DonorProfileEntity>> loadAvailableDonors() async {
    try {
      if (_getAvailableDonorsUseCase == null) {
        throw Exception('UseCase não configurado');
      }
      final donors = await _getAvailableDonorsUseCase!.call();
      notifyListeners();
      return donors;
    } catch (e) {
      throw Exception('Erro ao carregar doadores: $e');
    }
  }

  /// Busca doadores com filtros específicos
  Future<List<DonorProfileEntity>> searchDonorsWithFilters({
    int? minAge,
    int? maxAge,
    String? bloodType,
    String? education,
    String? eyeColor,
  }) async {
    try {
      if (_searchDonorsUseCase == null) {
        throw Exception('UseCase não configurado');
      }
      final donors = await _searchDonorsUseCase!.call(
        minAge: minAge,
        maxAge: maxAge,
        bloodType: bloodType,
        education: education,
        eyeColor: eyeColor,
      );
      notifyListeners();
      return donors;
    } catch (e) {
      throw Exception('Erro ao buscar doadores com filtros: $e');
    }
  }

  /// Cria um match entre demandante e doador
  Future<MatchEntity> createNewMatch(String demandanteId, String donorId) async {
    try {
      if (_createMatchUseCase == null) {
        throw Exception('UseCase não configurado');
      }
      final match = await _createMatchUseCase!.call(demandanteId, donorId);
      notifyListeners();
      return match;
    } catch (e) {
      throw Exception('Erro ao criar match: $e');
    }
  }

  /// Carrega matches do usuário para a tela de matches
  Future<List<MatchEntity>> loadUserMatches(String userId) async {
    try {
      if (_getMatchesUseCase == null) {
        throw Exception('UseCase não configurado');
      }
      final matches = await _getMatchesUseCase!.call(userId);
      notifyListeners();
      return matches;
    } catch (e) {
      throw Exception('Erro ao carregar matches: $e');
    }
  }

  /// Carrega perfil completo do usuário
  Future<Map<String, dynamic>> loadUserProfile(String userId) async {
    try {
      if (_getUserProfileUseCase == null) {
        throw Exception('UseCase não configurado');
      }
      final profile = await _getUserProfileUseCase!.call(userId);
      notifyListeners();
      return profile;
    } catch (e) {
      throw Exception('Erro ao carregar perfil: $e');
    }
  }

  /// Envia mensagem no chat
  Future<ChatMessageEntity> sendChatMessage({
    required String matchId,
    required String senderId,
    required String receiverId,
    required String content,
  }) async {
    try {
      if (_sendMessageUseCase == null) {
        throw Exception('UseCase não configurado');
      }
      final message = await _sendMessageUseCase!.call(
        matchId: matchId,
        senderId: senderId,
        receiverId: receiverId,
        content: content,
      );
      notifyListeners();
      return message;
    } catch (e) {
      throw Exception('Erro ao enviar mensagem: $e');
    }
  }

  /// Carrega mensagens do chat
  Future<List<ChatMessageEntity>> loadChatMessages(String matchId) async {
    try {
      if (_getChatMessagesUseCase == null) {
        throw Exception('UseCase não configurado');
      }
      final messages = await _getChatMessagesUseCase!.call(matchId);
      notifyListeners();
      return messages;
    } catch (e) {
      throw Exception('Erro ao carregar mensagens: $e');
    }
  }

  /// Exemplo de uso na tela Home Demandante - carrega dados em paralelo
  Future<Map<String, dynamic>> loadHomeDemandanteData(String userId) async {
    try {
      // Carrega dados em paralelo para melhor performance
      final results = await Future.wait([
        loadAvailableDonors(),
        loadUserMatches(userId),
        loadUserProfile(userId),
      ]);

      final data = {
        'donors': results[0] as List<DonorProfileEntity>,
        'matches': results[1] as List<MatchEntity>,
        'profile': results[2] as Map<String, dynamic>,
      };

      notifyListeners();
      return data;
    } catch (e) {
      throw Exception('Erro ao carregar dados da home: $e');
    }
  }

  /// Exemplo de uso na tela de Chat - carrega dados do chat
  Future<Map<String, dynamic>> loadChatData(String matchId) async {
    try {
      final messages = await loadChatMessages(matchId);

      final data = {
        'messages': messages,
        'matchId': matchId,
        'lastMessage': messages.isNotEmpty ? messages.last : null,
      };

      notifyListeners();
      return data;
    } catch (e) {
      throw Exception('Erro ao carregar dados do chat: $e');
    }
  }

  /// Fluxo completo: Demandante encontra doador e inicia conversa
  Future<Map<String, dynamic>> completeMatchFlow({
    required String demandanteId,
    required String donorId,
    required String initialMessage,
  }) async {
    try {
      // 1. Criar o match
      final match = await createNewMatch(demandanteId, donorId);

      // 2. Enviar mensagem inicial
      final message = await sendChatMessage(
        matchId: match.id,
        senderId: demandanteId,
        receiverId: donorId,
        content: initialMessage,
      );

      final result = {
        'match': match,
        'initialMessage': message,
        'success': true,
      };

      notifyListeners();
      return result;
    } catch (e) {
      return {
        'success': false,
        'error': 'Erro no fluxo de match: $e',
      };
    }
  }
}
