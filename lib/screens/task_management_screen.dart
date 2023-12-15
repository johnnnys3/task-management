// screens/task_management_screen.dart
import 'package:flutter/material.dart';
import 'package:task_management/screens/task_list_screen.dart';


class TaskManagementScreen extends StatelessWidget {
  final String userId;

  TaskManagementScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    // Navigate to the task list screen directly
    navigateToTaskListScreen(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void navigateToTaskListScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TaskListScreen(userId: userId, tasks: [],)),
    );
  }
}
