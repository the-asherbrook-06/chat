// packages
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnAuth();
  }

  Future<void> _navigateBasedOnAuth() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await Future.delayed(Duration(milliseconds: 300));
      final user = FirebaseAuth.instance.currentUser;
      if (!mounted) return;
      log(user.toString());
      (user != null)
          ? Navigator.pushNamedAndRemoveUntil(context, "/dashboard", (route) => false)
          : Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
