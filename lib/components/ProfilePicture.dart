// packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key, required this.user, required this.radius});

  final User? user;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: radius * 2,
        width: radius * 2,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Center(
          child: (user?.photoURL == null || user?.photoURL == '')
              ? Icon(
                  HugeIcons.strokeRoundedUser,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: radius,
                )
              : Image.network(user!.photoURL ?? "", fit: BoxFit.cover),
        ),
      ),
    );
  }
}
