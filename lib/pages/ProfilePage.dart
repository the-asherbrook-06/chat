// packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

// auth
import '../auth/Auth.dart';

// body
import 'package:chat/pages/views/ProfilePageBody.dart';

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
          BottomNavigationBarItem(icon: Icon(HugeIcons.strokeRoundedComment01), label: "chat"),
          BottomNavigationBarItem(icon: Icon(HugeIcons.strokeRoundedUserGroup02), label: "group"),
          BottomNavigationBarItem(icon: Icon(HugeIcons.strokeRoundedUser02), label: "group"),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ProfilePageBody(),
      )
    );
  }
}
