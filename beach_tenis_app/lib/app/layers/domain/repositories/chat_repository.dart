import 'package:beach_tenis_app/app/layers/domain/entities/chat_message_entity.dart';

abstract class IChatRepository {
  Future<List<ChatMessageEntity>> getMessagesByMatch(String matchId);
  Future<ChatMessageEntity> sendMessage(ChatMessageEntity message);
  Future<void> markMessageAsRead(String messageId);
  Future<List<ChatMessageEntity>> getUnreadMessages(String userId);
  Future<void> deleteMessage(String messageId);
  Future<ChatMessageEntity> updateMessage(ChatMessageEntity message);
}
