// packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class Auth {
  final _auth = FirebaseAuth.instance;

  User? getUserData() {
    return _auth.currentUser;
  }

  Future<void> register(BuildContext context, String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.reload();

      log("[Auth] User registered and displayName set: ${_auth.currentUser?.displayName}");
      Navigator.pushNamedAndRemoveUntil(context, "/dashboard", (context) => false);
    } catch (e) {
      log("[Auth] Registration error: $e");
    }
  }

  Future<void> login(BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      log("[Auth] User logged in successfully!");
      Navigator.pushNamedAndRemoveUntil(context, "/dashboard", (context) => false);
    } catch (e) {
      log("[Auth] Login error: $e");
    }
  }

  Future<void> logout(BuildContext context) async {
    await _auth.signOut();
    log("[Auth] User signed out!");
    Navigator.pushNamedAndRemoveUntil(context, '/', (context) => false);
  }

  void checkLoggedIn(BuildContext context) {
    final user = _auth.currentUser;
    if (user != null) {
      log("[Auth] User is already logged in!");
      Navigator.pushNamedAndRemoveUntil(context, "/dashboard", (context) => false);
    } else {
      log("[Auth] No user logged in.");
    }
  }
}
