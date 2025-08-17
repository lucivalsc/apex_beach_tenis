// Exemplo de como usar os casos de uso do Fertilink na camada de apresentação
// Este arquivo demonstra o fluxo completo da arquitetura Clean Architecture

import 'package:apex_sports/app/layers/domain/entities/chat_message_entity.dart';
import 'package:apex_sports/app/layers/domain/entities/donor_profile_entity.dart';
import 'package:apex_sports/app/layers/domain/entities/match_entity.dart';
import 'package:apex_sports/app/layers/domain/usecases/chat/chat_usecases.dart';
import 'package:apex_sports/app/layers/domain/usecases/donor/get_donors_usecase.dart';
import 'package:apex_sports/app/layers/domain/usecases/match/match_usecases.dart';
import 'package:apex_sports/app/layers/domain/usecases/user/user_profile_usecases.dart';

class FertilinkControllerExample {
  // Casos de uso injetados via dependency injection
  final GetAvailableDonorsUseCase getAvailableDonorsUseCase;
  final SearchDonorsUseCase searchDonorsUseCase;
  final CreateMatchUseCase createMatchUseCase;
  final GetMatchesUseCase getMatchesUseCase;
  final GetUserProfileUseCase getUserProfileUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final GetChatMessagesUseCase getChatMessagesUseCase;

  FertilinkControllerExample({
    required this.getAvailableDonorsUseCase,
    required this.searchDonorsUseCase,
    required this.createMatchUseCase,
    required this.getMatchesUseCase,
    required this.getUserProfileUseCase,
    required this.sendMessageUseCase,
    required this.getChatMessagesUseCase,
  });

  // Exemplo: Buscar doadores disponíveis para a tela Home Demandante
  Future<List<DonorProfileEntity>> loadAvailableDonors() async {
    try {
      final donors = await getAvailableDonorsUseCase.call();
      return donors;
    } catch (e) {
      throw Exception('Erro ao carregar doadores: $e');
    }
  }

  // Exemplo: Buscar doadores com filtros específicos
  Future<List<DonorProfileEntity>> searchDonorsWithFilters({
    int? minAge,
    int? maxAge,
    String? bloodType,
    String? education,
    String? eyeColor,
  }) async {
    try {
      final donors = await searchDonorsUseCase.call(
        minAge: minAge,
        maxAge: maxAge,
        bloodType: bloodType,
        education: education,
        eyeColor: eyeColor,
      );
      return donors;
    } catch (e) {
      throw Exception('Erro ao buscar doadores com filtros: $e');
    }
  }

  // Exemplo: Criar um match entre demandante e doador
  Future<MatchEntity> createNewMatch(String demandanteId, String donorId) async {
    try {
      final match = await createMatchUseCase.call(demandanteId, donorId);
      return match;
    } catch (e) {
      throw Exception('Erro ao criar match: $e');
    }
  }

  // Exemplo: Carregar matches do usuário para a tela de matches
  Future<List<MatchEntity>> loadUserMatches(String userId) async {
    try {
      final matches = await getMatchesUseCase.call(userId);
      return matches;
    } catch (e) {
      throw Exception('Erro ao carregar matches: $e');
    }
  }

  // Exemplo: Carregar perfil completo do usuário
  Future<Map<String, dynamic>> loadUserProfile(String userId) async {
    try {
      final profile = await getUserProfileUseCase.call(userId);
      return profile;
    } catch (e) {
      throw Exception('Erro ao carregar perfil: $e');
    }
  }

  // Exemplo: Enviar mensagem no chat
  Future<ChatMessageEntity> sendChatMessage({
    required String matchId,
    required String senderId,
    required String receiverId,
    required String content,
  }) async {
    try {
      final message = await sendMessageUseCase.call(
        matchId: matchId,
        senderId: senderId,
        receiverId: receiverId,
        content: content,
      );
      return message;
    } catch (e) {
      throw Exception('Erro ao enviar mensagem: $e');
    }
  }

  // Exemplo: Carregar mensagens do chat
  Future<List<ChatMessageEntity>> loadChatMessages(String matchId) async {
    try {
      final messages = await getChatMessagesUseCase.call(matchId);
      return messages;
    } catch (e) {
      throw Exception('Erro ao carregar mensagens: $e');
    }
  }

  // Exemplo de uso na tela Home Demandante
  Future<Map<String, dynamic>> loadHomeDemandanteData(String userId) async {
    try {
      // Carrega dados em paralelo para melhor performance
      final results = await Future.wait([
        loadAvailableDonors(),
        loadUserMatches(userId),
        loadUserProfile(userId),
      ]);

      return {
        'donors': results[0] as List<DonorProfileEntity>,
        'matches': results[1] as List<MatchEntity>,
        'profile': results[2] as Map<String, dynamic>,
      };
    } catch (e) {
      throw Exception('Erro ao carregar dados da home: $e');
    }
  }

  // Exemplo de uso na tela de Chat
  Future<Map<String, dynamic>> loadChatData(String matchId) async {
    try {
      final messages = await loadChatMessages(matchId);

      return {
        'messages': messages,
        'matchId': matchId,
        'lastMessage': messages.isNotEmpty ? messages.last : null,
      };
    } catch (e) {
      throw Exception('Erro ao carregar dados do chat: $e');
    }
  }

  // Exemplo de fluxo completo: Demandante encontra doador e inicia conversa
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

      return {
        'match': match,
        'initialMessage': message,
        'success': true,
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Erro no fluxo de match: $e',
      };
    }
  }
}
