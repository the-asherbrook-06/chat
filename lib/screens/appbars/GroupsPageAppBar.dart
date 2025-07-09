// packages
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

class GroupsPageAppBar extends StatelessWidget implements PreferredSizeWidget{
  const GroupsPageAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: Text("Groups"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(HugeIcons.strokeRoundedPencilEdit02)),
          IconButton(onPressed: () {}, icon: Icon(HugeIcons.strokeRoundedMoreVerticalCircle01)),
        ],
      );
  }
}