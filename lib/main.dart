// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/authentication/authentication_service.dart';
import 'package:task_management/authentication/firebase_config.dart';
import 'package:task_management/screens/home_screen.dart';
import 'package:task_management/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfig.initialize(); // Initialize Firebase

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthenticationService>(
      create: (context) => AuthenticationService(),
      child: MaterialApp(
        title: 'Task Management App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);

    return Consumer<User?>(
      builder: (context, user, _) {
        if (user != null) {
          // User is authenticated, show the home screen
          return HomeScreen(userId: user.uid);
        } else {
          // User is not authenticated, show the login screen
          return LoginScreen();
        }
      },
    );
  }
}
