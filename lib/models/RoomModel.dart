class Room {
  final String id;
  final String type;
  final List members;
  final String nickname;
  final String? lastMessageText;
  final String? lastSenderId;

  Room({
    required this.id,
    required this.type,
    required this.members,
    required this.nickname,
    this.lastMessageText,
    this.lastSenderId,
  });

  factory Room.fromMap(String id, Map<String, dynamic> data) {
    return Room(
      id: id,
      type: data['type'],
      members: List<String>.from(data['members']),
      nickname: data['nickname'] ?? '',
      lastMessageText: data['lastMessage']?['text'],
      lastSenderId: data['lastMessage']?['senderId'],
    );
  }
}
