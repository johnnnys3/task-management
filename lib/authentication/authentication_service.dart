import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/authentication/user.dart' as custom_user;

class AuthenticationService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  bool _keepSignedIn = false;

  User? get currentUser => _currentUser;

  bool get keepSignedIn => _keepSignedIn;

  set keepSignedIn(bool value) {
    _keepSignedIn = value;
    _saveKeepSignedInState(value);
    notifyListeners();
  }

  Future<void> _saveKeepSignedInState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('keepSignedIn', value);
  }

  Future<void> _loadKeepSignedInState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _keepSignedIn = prefs.getBool('keepSignedIn') ?? false;
    notifyListeners();
  }

  Stream<User?> get authStateChanges {
    return _auth.authStateChanges().map((User? user) {
      _currentUser = user;
      notifyListeners();
      return _currentUser;
    });
  }

  Future<User?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _auth.currentUser;
    } catch (e) {
      print('SignIn Error: $e');
      throw e;
    }
  }

  Future<custom_user.User?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      final customUser = _auth.currentUser != null
          ? custom_user.User(uid: _auth.currentUser!.uid, email: _auth.currentUser!.email!, role: 'regular')
          : null;

      notifyListeners();
      return customUser;
    } catch (e) {
      print('SignUp Error: $e');
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _currentUser = null; // Ensure _currentUser is cleared on sign-out
      notifyListeners();
    } catch (e) {
      print('SignOut Error: $e');
      throw e;
    }
  }

  AuthenticationService() {
    Future.delayed(Duration.zero, () async {
      await _loadKeepSignedInState();
    });
  }
}
