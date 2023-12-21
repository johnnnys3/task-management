import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart';
import 'package:intl/intl.dart';

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
            title: Text('Due Date: ${_formattedDate(task.dueDate)}'),
          ),
          ListTile(
            title: Text('Assigned To: ${task.assignedMembers.join(', ')}'),
          ),
          if (task.associatedProject != null)
            ListTile(
              title: Text('Associated Project: ${task.associatedProject!.name}'),
            ),
          // Add more details and attachments as needed
        ],
      ),
    );
  }

  String _formattedDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
