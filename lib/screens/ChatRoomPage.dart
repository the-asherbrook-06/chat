// packages
import 'package:flutter/material.dart';

class ChatRoomPage extends StatelessWidget {
  final String chatRoomId;
  const ChatRoomPage({super.key, required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: Center(child: Text("Chat room: $chatRoomId")),
    );
  }
}
