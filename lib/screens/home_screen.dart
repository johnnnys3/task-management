// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:task_management/screens/task_management_screen.dart';

class HomeScreen extends StatelessWidget {
  final String userId; // Assume the user ID is passed from the authentication process

  HomeScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskManagementScreen(userId: userId),
                  ),
                );
              },
              child: Text('Go to Task Management'),
            ),
            // Add more buttons for other features/screens
          ],
        ),
      ),
    );
  }
}
