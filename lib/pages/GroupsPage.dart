// packages
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

// body
import 'package:chat/pages/views/GroupsPageBody.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final List<String> _pages = ['/chats', '/groups', '/profile'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: Text("Groups"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(HugeIcons.strokeRoundedPencilEdit02)),
          IconButton(onPressed: () {}, icon: Icon(HugeIcons.strokeRoundedMoreVerticalCircle01)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (value) => Navigator.pushReplacementNamed(context, _pages[value]),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(HugeIcons.strokeRoundedComment01), label: "chat"),
          BottomNavigationBarItem(icon: Icon(HugeIcons.strokeRoundedUserGroup02), label: "group"),
          BottomNavigationBarItem(icon: Icon(HugeIcons.strokeRoundedUser02), label: "group"),
        ],
      ),
      body: GroupsPageBody()
    );
  }
}
