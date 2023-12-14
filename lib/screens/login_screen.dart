import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/authentication/authentication_service.dart';
import 'package:task_management/screens/home_screen.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                final authService = Provider.of<AuthenticationService>(context, listen: false);
                final user = await authService.signIn(email, password);

                if (user != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen(userId: '',)),
                  );
                } else {
                  // Show error message
                  // e.g., Fluttertoast.showToast(msg: 'Login failed');
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                // Navigate to registration screen
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}