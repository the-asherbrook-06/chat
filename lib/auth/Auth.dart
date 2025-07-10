// packages
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';

class Auth {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;

  User? getUserData() {
    return _auth.currentUser;
  }

  Future<void> setName(String name) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
      await user.reload();
      log("[Auth] Display name updated to: ${user.displayName}");

      // Update Firestore
      await storeUserDataToFirestore(user);
    } else {
      log("[Auth] No user is signed in to update name.");
    }
  }

  Future<void> updateProfilePicture(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    final File file = File(pickedFile.path);
    final user = _auth.currentUser;

    if (user == null) return;

    final ref = _storage.ref().child("userData/${user.uid}/profilePicture.jpg");
    await ref.putFile(file);
    final downloadUrl = await ref.getDownloadURL();

    await user.updatePhotoURL(downloadUrl);
    await user.reload();
    log("[Auth] Profile picture updated: $downloadUrl");

    // Update Firestore
    await storeUserDataToFirestore(user);
  }

  Future<void> register(BuildContext context, String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.reload();
      User? user = _auth.currentUser;

      if (user != null) {
        await storeUserDataToFirestore(user);
      }

      log("[Auth] User registered and displayName set: ${_auth.currentUser?.displayName}");
      Navigator.pushNamedAndRemoveUntil(context, "/dashboard", (context) => false);
    } catch (e) {
      log("[Auth] Registration error: $e");
    }
  }

  Future<void> login(BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = _auth.currentUser;
      if (user != null) {
        await storeUserDataToFirestore(user);
      }

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

  Future<void> storeUserDataToFirestore(User user) async {
    final userDoc = _firestore.collection('users').doc(user.uid);
    final snapshot = await userDoc.get();

    final data = {
      'uid': user.uid,
      'email': user.email?.toLowerCase(),
      'name': user.displayName ?? '',
      'profilePic': user.photoURL ?? '',
      'lastSeen': FieldValue.serverTimestamp(),
    };

    if (!snapshot.exists) {
      await userDoc.set(data);
      log("[Firestore] User data created for ${user.email}");
    } else {
      Map<String, dynamic> updates = {};
      final existingData = snapshot.data()!;
      data.forEach((key, value) {
        if (existingData[key] != value && value != null) {
          updates[key] = value;
        }
      });

      if (updates.isNotEmpty) {
        await userDoc.update(updates);
        log("[Firestore] User data updated: $updates");
      } else {
        log("[Firestore] No changes detected for ${user.email}");
      }
    }
  }
}
