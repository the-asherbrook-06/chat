// packages
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

// appbars
import 'package:chat/screens/appbars/ChatsPageAppBar.dart';
import 'package:chat/screens/appbars/ProfilePageAppBar.dart';

// body
import 'views/ProfilePageBody.dart';
import 'views/ChatPageBody.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;
  final List<Widget> _views = [ChatPageBody(), ProfilePageBody()];
  final List<PreferredSizeWidget> _appBars = [ChatsPageAppBar(), ProfilePageAppBar()];

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
          BottomNavigationBarItem(icon: Icon(HugeIcons.strokeRoundedUser02), label: "profile"),
        ],
      ),
      body: _views[currentIndex],
    );
  }
}
