// packages
import 'package:svg_flutter/svg_flutter.dart';
import 'package:flutter/material.dart';

class GroupsPageBody extends StatefulWidget {
  const GroupsPageBody({super.key});

  @override
  State<GroupsPageBody> createState() => _GroupsPageBodyState();
}

class _GroupsPageBodyState extends State<GroupsPageBody> {
  // TODO: Update _chats variable
  final List _chats = [];

  @override
  Widget build(BuildContext context) {
    final theme = (View.of(context).platformDispatcher.platformBrightness == Brightness.light)
        ? "light"
        : "dark";

    return (_chats.isEmpty)
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
        : ListView(children: []);
    // TODO: Make into a ListView.builder();
  }
}
