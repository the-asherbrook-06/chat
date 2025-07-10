class ChatRoom {
  final String id;
  final String type;
  final List members;
  final String? lastMessageText;
  final String? lastSenderId;

  ChatRoom({
    required this.id,
    required this.type,
    required this.members,
    this.lastMessageText,
    this.lastSenderId,
  });

  factory ChatRoom.fromMap(String id, Map<String, dynamic> data) {
    return ChatRoom(
      id: id,
      type: data['type'],
      members: List<String>.from(data['members']),
      lastMessageText: data['lastMessage']?['text'],
      lastSenderId: data['lastMessage']?['senderId'],
    );
  }
}
