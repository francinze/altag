import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HouseAuthProvider extends ChangeNotifier {
  User? _user;
  late FirebaseAuth instance;

  HouseAuthProvider(FirebaseAuth? auth) {
    if (auth != null) {
      instance = auth;
    } else {
      instance = FirebaseAuth.instance;
    }
    // Listen to auth state changes
    instance.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners(); // Notify listeners when the auth state changes
    });
  }

  // Getter for the current user
  User? get user => _user;

  // Check if user is logged in
  bool get isLoggedIn => _user != null;

  // Logout
  Future<void> logout() async {
    try {
      await instance.signOut();
    } catch (_) {
      rethrow;
    }
  }
}
