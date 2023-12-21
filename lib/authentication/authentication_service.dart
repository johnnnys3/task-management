import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/authentication/user.dart';
import 'package:flutter/foundation.dart'; // Import this to use ChangeNotifier

class AuthenticationService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late StreamController<CustomUser?> _authStateController;
  late SharedPreferences prefs;

  CustomUser? get currentUser => _auth.currentUser != null
      ? CustomUser(uid: _auth.currentUser!.uid, email: _auth.currentUser!.email!, role: prefs.getString('userRole') ?? 'regular')
      : null;

  Stream<CustomUser?> get authStateChanges {
    return _authStateController.stream;
  }

  bool get keepSignedIn => prefs.getBool('keepSignedIn') ?? false;

  set keepSignedIn(bool value) {
    prefs.setBool('keepSignedIn', value);
    notifyListeners();
  }

  bool get isAdmin => prefs.getString('userRole') == 'admin';

  AuthenticationService() {
    _authStateController = StreamController<CustomUser?>();
    init();
  }

  Future<void> init() async {
    SharedPreferences.getInstance().then((_prefs) {
      prefs = _prefs;
      _auth.authStateChanges().listen((User? user) {
        if (user == null) {
          _authStateController.add(null);
        } else {
          _authStateController.add(currentUser);
        }
      });
    });
  }

  Future<CustomUser?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _auth.currentUser != null
          ? CustomUser(uid: _auth.currentUser!.uid, email: _auth.currentUser!.email!, role: prefs.getString('userRole') ?? 'regular')
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
      await prefs.setString('userRole', role);
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
      _authStateController.add(null);
    } catch (e) {
      print('SignOut Error: $e');
      throw e;
    }
  }

  void notifyListeners() {
    _authStateController.add(currentUser);
  }
}
