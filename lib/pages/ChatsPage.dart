// packages
import 'package:chat/pages/appbars/ChatsPageAppBar.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

// body
import 'views/ChatPageBody.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final List<String> _pages = ['/chats', '/groups', '/profile'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: ChatsPageAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (value) => Navigator.pushReplacementNamed(context, _pages[value]),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(HugeIcons.strokeRoundedComment01), label: "chat"),
          BottomNavigationBarItem(icon: Icon(HugeIcons.strokeRoundedUserGroup02), label: "group"),
          BottomNavigationBarItem(icon: Icon(HugeIcons.strokeRoundedUser02), label: "group"),
        ],
      ),
      body: ChatPageBody(),
    );
  }
}
