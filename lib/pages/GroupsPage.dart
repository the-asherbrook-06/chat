// packages
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final List<String> _pages = ['/chats', '/groups', '/profile'];
  // TODO: Update _chats variable
  final List _chats = [];

  @override
  Widget build(BuildContext context) {
    final theme = (View.of(context).platformDispatcher.platformBrightness == Brightness.light)
        ? "light"
        : "dark";

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
      body: (_chats.isEmpty)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/$theme/begin_group_chat.svg", width: 250),
                  SizedBox(height: 32),
                  Text(
                    "Looks like no one’s talking yet",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Start a chat to see messages here",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 24),
                ],
              ),
            )
          : ListView(children: []),
      // TODO: Make into a ListView.builder()
    );
  }
}
