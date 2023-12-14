// screens/task_list_screen.dart
import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart';

class TaskListScreen extends StatefulWidget {
  final String userId;

  TaskListScreen({required this.userId});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = []; // Populate this list with tasks from Firestore or another database

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].title),
            subtitle: Text(tasks[index].description),
            onTap: () {
              // Handle task details or updates
            },
          );
        },
      ),
    );
  }
}