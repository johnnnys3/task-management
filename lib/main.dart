// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/authentication/authentication_service.dart';
import 'package:task_management/authentication/firebase_config.dart';
import 'package:task_management/authentication/user.dart';
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
          primarySwatch: Colors.orange, // Set primary color to orange
          primaryColor: Colors.orange, // Set primary color to orange
          hintColor: Colors.black, // Set accent color to black
          scaffoldBackgroundColor: Colors.white, // Set scaffold background color to white
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

    return StreamBuilder<CustomUser?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        final user = snapshot.data;

        if (user != null) {
          // User is authenticated, fetch isAdmin value from AuthenticationService
          bool isAdmin = authService.isAdmin ?? false;

          return HomeScreen(user: user, userId: '', isAdmin: isAdmin);
        } else {
          // User is not authenticated, show the login screen
          return LoginScreen();
        }
      },
    );
  }
}

