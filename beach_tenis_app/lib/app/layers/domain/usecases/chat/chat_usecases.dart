import 'package:beach_tenis_app/app/layers/domain/entities/chat_message_entity.dart';
import 'package:beach_tenis_app/app/layers/domain/repositories/chat_repository.dart';

class GetChatMessagesUseCase {
  final IChatRepository repository;

  GetChatMessagesUseCase(this.repository);

  Future<List<ChatMessageEntity>> call(String matchId) async {
    return await repository.getMessagesByMatch(matchId);
  }
}

class SendMessageUseCase {
  final IChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<ChatMessageEntity> call({
    required String matchId,
    required String senderId,
    required String receiverId,
    required String content,
    String messageType = 'text',
    String? attachmentUrl,
    String? attachmentType,
  }) async {
    final message = ChatMessageEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      matchId: matchId,
      senderId: senderId,
      receiverId: receiverId,
      content: content,
      messageType: messageType,
      sentAt: DateTime.now(),
      isEncrypted: true,
      attachmentUrl: attachmentUrl,
      attachmentType: attachmentType,
    );

    return await repository.sendMessage(message);
  }
}

class MarkMessageAsReadUseCase {
  final IChatRepository repository;

  MarkMessageAsReadUseCase(this.repository);

  Future<void> call(String messageId) async {
    return await repository.markMessageAsRead(messageId);
  }
}

class GetUnreadMessagesUseCase {
  final IChatRepository repository;

  GetUnreadMessagesUseCase(this.repository);

  Future<List<ChatMessageEntity>> call(String userId) async {
    return await repository.getUnreadMessages(userId);
  }
}
