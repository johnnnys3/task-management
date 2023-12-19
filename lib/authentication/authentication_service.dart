import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/authentication/user.dart';

class AuthenticationService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CustomUser? _currentUser;
  bool _keepSignedIn = false;

  CustomUser? get currentUser => _currentUser;

  bool get isAdmin => _currentUser?.role == 'admin';

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

  Stream<CustomUser?> get authStateChanges {
    return _auth.authStateChanges().map((User? user) {
      _currentUser = user != null
          ? CustomUser(uid: user.uid, email: user.email!, role: 'regular')
          : null;
      
      // Check if the user is an admin and update the role accordingly
      if (_currentUser != null) {
        _currentUser = _currentUser!.copyWith(role: isAdmin ? 'admin' : 'regular');
      }

      notifyListeners();
      return _currentUser;
    });
  }

  Future<CustomUser?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _auth.currentUser != null
          ? CustomUser(uid: _auth.currentUser!.uid, email: _auth.currentUser!.email!, role: isAdmin ? 'admin' : 'regular')
          : null;
    } catch (e) {
      print('SignIn Error: $e');
      throw e;
    }
  }

  Future<CustomUser?> signUp(String email, String password, String role) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      final customUser = _auth.currentUser != null
          ? CustomUser(uid: _auth.currentUser!.uid, email: _auth.currentUser!.email!, role: role)
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
