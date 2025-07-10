// packages
import 'package:flutter/material.dart';

class GroupsPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GroupsPageAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      title: Text("Groups"),
    );
  }
}
