// registration_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/authentication/authentication_service.dart';
import 'package:task_management/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isAdmin = false;
  bool isRegular = true; // Set a default role

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Row(
              children: [
                Checkbox(
                  value: isAdmin,
                  onChanged: (value) {
                    setState(() {
                      isAdmin = value!;
                      if (value) {
                        isRegular = false; // Uncheck regular if admin is checked
                      }
                    });
                  },
                ),
                Text('Admin'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: isRegular,
                  onChanged: (value) {
                    setState(() {
                      isRegular = value!;
                      if (value) {
                        isAdmin = false; // Uncheck admin if regular is checked
                      }
                    });
                  },
                ),
                Text('Regular'),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final email = emailController.text.trim();
                final password = passwordController.text.trim();
                final role = isAdmin ? 'admin' : 'regular'; // Determine the role

                final authService =
                    Provider.of<AuthenticationService>(context, listen: false);

                try {
                  // Sign up with name, email, password, and role
                  final user = await authService.signUp(name, email, password, role);

                  if (user != null) {
                    // Registration successful, navigate back to login page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  } else {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Registration failed. Please try again.'),
                      ),
                    );
                  }
                } catch (e) {
                  // Handle other registration errors
                  print('Registration Error: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('An error occurred. Please try again.'),
                    ),
                  );
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
