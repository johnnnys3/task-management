import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart'; // Import this for ChangeNotifier
import 'package:task_management/authentication/user.dart' as custom_user;

class AuthenticationService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<User?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
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
}
