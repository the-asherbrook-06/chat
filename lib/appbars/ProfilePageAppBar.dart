// packages
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

// auth
import 'package:chat/auth/Auth.dart';

class ProfilePageAppBar extends StatelessWidget implements PreferredSizeWidget{
  const ProfilePageAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    Auth auth = Auth();

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      title: Text("Profile"),
      actions: [
        IconButton(
          onPressed: () => auth.logout(context),
          icon: Icon(HugeIcons.strokeRoundedLogout01, color: Theme.of(context).colorScheme.error),
        ),
      ],
    );
  }
}
