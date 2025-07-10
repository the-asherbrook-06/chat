// packages
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ChatsPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatsPageAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      title: Text("Chats"),
      actions: [
        PopupMenuButton(
          borderRadius: BorderRadius.circular(14),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          icon: Icon(HugeIcons.strokeRoundedPencilEdit02),
          onSelected: (value) {
            if (value == 'chat') {
              Navigator.pushNamed(context, '/newChat');
            } else if (value == 'group') {
              Navigator.pushNamed(context, '/newGroup');
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'chat',
              child: Row(
                children: [
                  Icon(HugeIcons.strokeRoundedUser02),
                  SizedBox(width: 12),
                  Text("New Chat"),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'group',
              child: Row(
                children: [
                  Icon(HugeIcons.strokeRoundedUserGroup),
                  SizedBox(width: 12),
                  Text("New Group"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
