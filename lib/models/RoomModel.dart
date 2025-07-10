class Room {
  final String id;
  final String type;
  final List members;
  final String nickname;
  final String groupPic;
  final String? lastMessageText;
  final String? lastSenderId;

  Room({
    required this.id,
    required this.type,
    required this.members,
    required this.nickname,
    required this.groupPic,
    this.lastMessageText,
    this.lastSenderId,
  });

  factory Room.fromMap(String id, Map<String, dynamic> data) {
    return Room(
      id: id,
      type: data['type'],
      members: List<String>.from(data['members']),
      nickname: data['nickname'] ?? '',
      groupPic: data['groupPic'] ?? '',
      lastMessageText: data['lastMessage']?['text'],
      lastSenderId: data['lastMessage']?['senderId'],
    );
  }
}
