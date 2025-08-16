class ChatMessageEntity {
  final String id;
  final String matchId;
  final String senderId;
  final String receiverId;
  final String content;
  final String messageType; // 'text', 'image', 'document'
  final DateTime sentAt;
  final DateTime? readAt;
  final bool isEncrypted;
  final String? attachmentUrl;
  final String? attachmentType;

  const ChatMessageEntity({
    required this.id,
    required this.matchId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.messageType,
    required this.sentAt,
    this.readAt,
    required this.isEncrypted,
    this.attachmentUrl,
    this.attachmentType,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'matchId': matchId,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'messageType': messageType,
      'sentAt': sentAt.toIso8601String(),
      'readAt': readAt?.toIso8601String(),
      'isEncrypted': isEncrypted,
      'attachmentUrl': attachmentUrl,
      'attachmentType': attachmentType,
    };
  }

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) {
    return ChatMessageEntity(
      id: json['id'],
      matchId: json['matchId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content: json['content'],
      messageType: json['messageType'],
      sentAt: DateTime.parse(json['sentAt']),
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt']) : null,
      isEncrypted: json['isEncrypted'],
      attachmentUrl: json['attachmentUrl'],
      attachmentType: json['attachmentType'],
    );
  }
}
