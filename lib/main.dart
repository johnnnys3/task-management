// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/authentication/authentication_service.dart';
import 'package:task_management/screens/home_screen.dart';
import 'package:task_management/screens/login_screen.dart';

void main() {
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    return ChangeNotifierProvider(
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

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;

          if (user != null) {
            // User is authenticated, show the home screen
            return HomeScreen(userId: user.uid);
          } else {
            // User is not authenticated, show the login screen
            return LoginScreen();
          }
        }

        // Show a loading indicator or splash screen while checking authentication state
        return CircularProgressIndicator();
      },
    );
 }
}