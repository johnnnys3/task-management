// screens/task_details_screen.dart
import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Task task;

  TaskDetailsScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
          ),
          ListTile(
            title: Text('Due Date: ${task.dueDate}'),
            subtitle: Text('Priority: ${task.priority}'),
          ),
          ListTile(
            title: Text('Assigned To: ${task.assignedTo}'),
          ),
          // Add more details and attachments as needed
        ],
      ),
    );
  }
}
