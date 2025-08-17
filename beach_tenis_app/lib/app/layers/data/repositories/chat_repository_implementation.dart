import 'package:apex_sports/app/layers/data/datasources/remote/remote_data_datasource.dart';
import 'package:apex_sports/app/layers/domain/entities/chat_message_entity.dart';
import 'package:apex_sports/app/layers/domain/repositories/chat_repository.dart';

class ChatRepositoryImplementation implements IChatRepository {
  final IRemoteDataDatasource remoteDataSource;

  ChatRepositoryImplementation(this.remoteDataSource);

  @override
  Future<List<ChatMessageEntity>> getMessagesByMatch(String matchId) async {
    try {
      final chatData = await remoteDataSource.getChatMessages(matchId);
      final messagesData = chatData['data'] as List;
      return messagesData.map((messageData) => ChatMessageEntity.fromJson(messageData)).toList();
    } catch (e) {
      throw Exception('Erro ao buscar mensagens do chat: ${e.toString()}');
    }
  }

  @override
  Future<ChatMessageEntity> sendMessage(ChatMessageEntity message) async {
    try {
      final response = await remoteDataSource.sendMessage(message.toJson());
      final messageData = response['data'];
      return ChatMessageEntity.fromJson(messageData);
    } catch (e) {
      throw Exception('Erro ao enviar mensagem: ${e.toString()}');
    }
  }

  @override
  Future<void> markMessageAsRead(String messageId) async {
    try {
      // Implementação será adicionada quando o endpoint estiver disponível
      await Future.delayed(const Duration(milliseconds: 200));
      return;
    } catch (e) {
      throw Exception('Erro ao marcar mensagem como lida: ${e.toString()}');
    }
  }

  @override
  Future<List<ChatMessageEntity>> getUnreadMessages(String userId) async {
    try {
      // Implementação será adicionada quando o endpoint estiver disponível
      await Future.delayed(const Duration(milliseconds: 300));
      return [];
    } catch (e) {
      throw Exception('Erro ao buscar mensagens não lidas: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    try {
      // Implementação será adicionada quando o endpoint estiver disponível
      await Future.delayed(const Duration(milliseconds: 200));
      return;
    } catch (e) {
      throw Exception('Erro ao excluir mensagem: ${e.toString()}');
    }
  }

  @override
  Future<ChatMessageEntity> updateMessage(ChatMessageEntity message) async {
    try {
      // Implementação será adicionada quando o endpoint estiver disponível
      await Future.delayed(const Duration(milliseconds: 300));
      return message;
    } catch (e) {
      throw Exception('Erro ao atualizar mensagem: ${e.toString()}');
    }
  }
}
