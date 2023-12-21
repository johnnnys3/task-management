import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'user.dart';

class AuthenticationService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late StreamController<CustomUser?> _authStateController;
  late SharedPreferences prefs;
  final CollectionReference<Map<String, dynamic>> _userCollection =
      FirebaseFirestore.instance.collection('users'); // Replace with your actual collection

  bool _isRoleSelected = false;
  bool get isRoleSelected => _isRoleSelected;
  set isRoleSelected(bool value) {
    _isRoleSelected = value;
    notifyListeners();
  }

  String _selectedRole = '';
  String get selectedRole => _selectedRole;
  set selectedRole(String value) {
    _selectedRole = value;
    notifyListeners();
  }

  CustomUser? get currentUser => _auth.currentUser != null
      ? CustomUser(
          uid: _auth.currentUser!.uid,
          email: _auth.currentUser!.email!,
          role: prefs.getString('userRole') ?? 'regular',
          assignedProjects: [],
          name: _auth.currentUser!.displayName ?? '',
        )
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

  Future<CustomUser?> signIn(String name, String email, String password) async {
    try {
      // Check if role selection is required
      if (isRoleSelected) {
        final QuerySnapshot<Map<String, dynamic>> result = await _userCollection
            .where('name', isEqualTo: name)
            .where('email', isEqualTo: email)
            .get();

        if (result.docs.isEmpty) {
          print('User with name $name and email $email not found.');
          return null;
        }

        final userDoc = result.docs.first;
        final userData = userDoc.data() as Map<String, dynamic>;

        if (userData['role'] != selectedRole) {
          print('User with name $name does not have the selected role.');
          return null;
        }
      }

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        print('Authentication failed.');
        return null;
      }

      final customUser = CustomUser(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email!,
        role: selectedRole,
        assignedProjects: [],
        name: name,
      );

      notifyListeners();
      return customUser;
    } catch (e) {
      print('SignIn Error: $e');
      throw e;
    }
  }

  Future<CustomUser?> signUp(String name, String email, String password, String role) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      await _auth.currentUser?.updateDisplayName(name);

      final customUser = CustomUser(
        uid: _auth.currentUser!.uid,
        email: _auth.currentUser!.email!,
        role: role,
        assignedProjects: [],
        name: _auth.currentUser!.displayName ?? '',
      );

      await prefs.setString('userRole', customUser.role);
      notifyListeners();

      await _userCollection.doc(customUser.uid).set({
        'name': customUser.name,
        'email': customUser.email,
        'role': customUser.role,
      });

      return customUser;
    } catch (e) {
      print('SignUp Error: $e');
      throw e;
    }
  }

  Future<List<String>> fetchAssignedMembers(String username) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _userCollection.doc(username).get();

      if (userSnapshot.exists) {
        final List<dynamic> assignedProjects =
            userSnapshot.data()?['assignedProjects'] ?? [];
        return assignedProjects.cast<String>();
      } else {
        return [];
      }
    } catch (error) {
      print('Error fetching assigned members: $error');
      throw error;
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
