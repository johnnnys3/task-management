import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management/authentication/user.dart' as custom_user;

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _auth.currentUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<custom_user.User?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      return _auth.currentUser != null
          ? custom_user.User(uid: _auth.currentUser!.uid, email: _auth.currentUser!.email!, role: 'regular')
          : null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
