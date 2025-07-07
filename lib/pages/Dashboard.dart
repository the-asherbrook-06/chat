// packages
import 'package:chat/pages/appbars/ChatsPageAppBar.dart';
import 'package:chat/pages/appbars/GroupsPageAppBar.dart';
import 'package:chat/pages/appbars/ProfilePageAppBar.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

// body
import './views/ProfilePageBody.dart';
import './views/GroupsPageBody.dart';
import './views/ChatPageBody.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;
  final List<Widget> _views = [ChatPageBody(), GroupsPageBody(), ProfilePageBody()];
  final List<PreferredSizeWidget> _appBars = [ChatsPageAppBar(), GroupsPageAppBar(), ProfilePageAppBar()];

  void updateIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => updateIndex(index),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(HugeIcons.strokeRoundedComment01), label: "chat"),
          BottomNavigationBarItem(icon: Icon(HugeIcons.strokeRoundedUserGroup02), label: "group"),
          BottomNavigationBarItem(icon: Icon(HugeIcons.strokeRoundedUser02), label: "group"),
        ],
      ),
      body: _views[currentIndex],
    );
  }
}
