import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

class ProfilePictureURL extends StatelessWidget {
  const ProfilePictureURL({super.key, required this.type, required this.URL, required this.radius});

  final double radius;
  final String type;
  final String URL;

  @override
  Widget build(BuildContext context) {
    // Choose the icon based on the type
    IconData iconData;
    switch (type) {
      case 'group':
        iconData = HugeIcons.strokeRoundedUserGroup02;
        break;
      case 'chat':
      case 'user':
        iconData = HugeIcons.strokeRoundedUser02;
        break;
      case 'profile':
      default:
        iconData = HugeIcons.strokeRoundedUser03;
        break;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: radius * 2,
        width: radius * 2,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Center(
          child: (URL.isEmpty)
              ? Icon(iconData, color: Theme.of(context).colorScheme.onSurface, size: radius)
              : Image.network(
                  URL,
                  fit: BoxFit.cover,
                  width: radius * 2,
                  height: radius * 2,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      iconData,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: radius,
                    );
                  },
                ),
        ),
      ),
    );
  }
}
