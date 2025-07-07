// packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

// auth
import '../auth/Auth.dart';

// components
import '../components/ProfilePicture.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> _pages = ['/chats', '/groups', '/profile'];
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: Text("Profile"),
        actions: [
          IconButton(
            onPressed: () => auth.logout(context),
            icon: Icon(HugeIcons.strokeRoundedLogout01, color: Theme.of(context).colorScheme.error),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (value) => Navigator.pushReplacementNamed(context, _pages[value]),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(HugeIcons.strokeRoundedBubbleChat), label: "chat"),
          BottomNavigationBarItem(icon: Icon(HugeIcons.strokeRoundedUserGroup02), label: "group"),
          BottomNavigationBarItem(icon: Icon(HugeIcons.strokeRoundedUser02), label: "group"),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
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
          ],
        ),
      ),
    );
  }
}
