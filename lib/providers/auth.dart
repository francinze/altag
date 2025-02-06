import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HouseAuthProvider extends ChangeNotifier {
  String? _uid;
  String? _userName;
  late FirebaseAuth instance;
  final Box<String> _authBox = Hive.box<String>('authBox');

  HouseAuthProvider([FirebaseAuth? auth]) {
    instance = auth ?? FirebaseAuth.instance;
    _loadUser();
  }

  String? get userName => _userName;
  String? get uid => _uid;
  bool get isLoggedIn => _userName != null && _uid != null;

  /// Load user data from Hive storage
  void _loadUser() {
    _userName = _authBox.get('userName');
    _uid = _authBox.get('uid');
    notifyListeners();
  }

  /// Generate a persistent UID (random string)
  String _generateUID() {
    final random = Random();
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(16, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  /// Attempt to sign in with a username
  Future<void> signInWithUsername(String username) async {
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(username);
    final userDoc = await userRef.get();

    if (userDoc.exists) {
      // Username exists, retrieve the stored UID
      final data = userDoc.data() as Map<String, dynamic>;
      _uid = data['uid'];
    } else {
      // Username doesn't exist, create a new user
      _uid = _generateUID();
      await userRef.set({
        'uid': _uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    // Save username and UID locally using Hive
    _authBox.put('userName', username);
    _authBox.put('uid', _uid!);

    _userName = username;
    notifyListeners();
  }

  /// Log out the user
  Future<void> logout() async {
    await _authBox.delete('userName');
    await _authBox.delete('uid');

    _userName = null;
    _uid = null;
    notifyListeners();
  }
}
