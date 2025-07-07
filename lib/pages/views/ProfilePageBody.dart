// packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

// auth
import '../../auth/Auth.dart';

// components
import '../../components/ProfilePicture.dart';
import '../../components/QuotesContainer.dart';

class ProfilePageBody extends StatefulWidget {
  const ProfilePageBody({super.key});

  @override
  State<ProfilePageBody> createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<ProfilePageBody> {
  Auth auth = Auth();
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.getUserData();
    // TODO: Remove Log
    log(user.toString());
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ProfilePicture(user: user, radius: 60),
                SizedBox(height: 16),
                Text(
                  user?.displayName ?? "",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(user!.email ?? "Email", style: Theme.of(context).textTheme.bodyLarge),
                Text(
                  user!.uid,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 14),
                TextButton(onPressed: () {}, child: Text("Edit Profile")),
              ],
            ),
          ),
        ),
        SizedBox(height: 4),
        QuotesContainer(),
      ],
    );
  }
}