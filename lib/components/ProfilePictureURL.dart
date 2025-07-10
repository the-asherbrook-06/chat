// packages
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

class ProfilePictureURL extends StatelessWidget {
  const ProfilePictureURL({super.key, required this.URL, required this.radius});

  final String URL;
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
          child: (URL == '' || URL.isEmpty)
              ? Icon(
                  HugeIcons.strokeRoundedUser,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: radius,
                )
              : Image.network(URL, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
