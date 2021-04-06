import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Auth extends ChangeNotifier {
  final _refrence = FirebaseAuth.instance;
  bool verifiedUser = false;
  Stream<User> get onAuthChange {
    return _refrence.authStateChanges().map(_userDetailsOfFirebase);
  }

  Future<User> signInEmailandPassword(String email, String password) async {
    try {
      final result = await _refrence.signInWithEmailAndPassword(
          email: email, password: password);
      notifyListeners();
      return _userDetailsOfFirebase(result.user);
    } catch (e) {
      throw Exception(e.message);
    }
  }

  Future<User> createEmailandPassword(String email, String password) async {
    try {
      final result = await _refrence.createUserWithEmailAndPassword(
          email: email, password: password);
      notifyListeners();
      return _userDetailsOfFirebase(result.user);
    } catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> verifyEmail() async {
    await _refrence.currentUser.sendEmailVerification();
    notifyListeners();
  }

  Future<void> reloadUserStatus() async {
    await _refrence.currentUser.reload();
    if (_refrence.currentUser.emailVerified == true) {
      verifiedUser = true;
      notifyListeners();
    }
  }

  Future<void> sendPasswordRestLink(String email) async {
    await _refrence.sendPasswordResetEmail(email: email);
  }

  User _userDetailsOfFirebase(user) {
    if (user == null) {
      return null;
    } else {
      return User(
        uid: user.uid,
        email: user.email,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _refrence.signOut();
      notifyListeners();
    } catch (e) {
      throw Exception(e.message);
    }
  }
}

class User extends ChangeNotifier {
  final String uid;
  final String email;
  User({
    @required this.uid,
    @required this.email,
  });
}
