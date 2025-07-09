import 'package:svg_flutter/svg_flutter.dart';
import 'package:flutter/material.dart';

class GroupsPageBody extends StatefulWidget {
  const GroupsPageBody({super.key});

  @override
  State<GroupsPageBody> createState() => _GroupsPageBodyState();
}

class _GroupsPageBodyState extends State<GroupsPageBody> {
  final List _chats = [];

  @override
  Widget build(BuildContext context) {
    final theme = (View.of(context).platformDispatcher.platformBrightness == Brightness.light)
        ? "light"
        : "dark";

    return Column(
      children: [
        // 🔍 Always show the search bar
        Padding(
          padding: const EdgeInsets.all(8),
          child: SearchBar(
            elevation: WidgetStatePropertyAll(1),
            hintText: 'Search',
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            leading: Icon(Icons.search),
          ),
        ),

        Expanded(
          child: _chats.isEmpty
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
              : ListView.builder(
                  itemCount: _chats.length,
                  itemBuilder: (context, index) {
                    final chat = _chats[index];
                    return ListTile(
                      title: Text(chat['name']),
                      subtitle: Text(chat['lastMessage'] ?? ''),
                      onTap: () {
                        // open group chat
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
