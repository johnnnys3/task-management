import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/authentication/user.dart'as custom_user;

class AuthenticationService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _keepSignedIn = false;

  User? get currentUser => _auth.currentUser;

  bool get keepSignedIn => _keepSignedIn;

  set keepSignedIn(bool value) {
    _keepSignedIn = value;
    _saveKeepSignedInState(value); // Save the state when it changes
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

  Future<User?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // If the user chooses not to keep signed in, sign them out when the app restarts
      if (!_keepSignedIn) {
        await signOut();
      }

      notifyListeners(); // Notify listeners when the authentication state changes
      return _auth.currentUser;
    } catch (e) {
      print('SignIn Error: $e');
      throw e; // Propagate the error to handle it in UI
    }
  }

  Future<custom_user.User?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      final customUser = _auth.currentUser != null
          ? custom_user.User(uid: _auth.currentUser!.uid, email: _auth.currentUser!.email!, role: 'regular')
          : null;

      // If the user chooses not to keep signed in, sign them out when the app restarts
      if (!_keepSignedIn) {
        await signOut();
      }

      notifyListeners(); // Notify listeners when the authentication state changes
      return customUser;
    } catch (e) {
      print('SignUp Error: $e');
      throw e; // Propagate the error to handle it in UI
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      notifyListeners(); // Notify listeners when the authentication state changes
    } catch (e) {
      print('SignOut Error: $e');
      throw e; // Propagate the error to handle it in UI
    }
  }

  AuthenticationService() {
    _loadKeepSignedInState(); // Load the keep signed in state when the AuthenticationService is initialized
  }
}
