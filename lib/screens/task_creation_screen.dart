// screens/task_creation_screen.dart
import 'package:flutter/material.dart';

class TaskCreationScreen extends StatefulWidget {
  @override
  _TaskCreationScreenState createState() => _TaskCreationScreenState();
}

class _TaskCreationScreenState extends State<TaskCreationScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime selectedDueDate = DateTime.now();
  int selectedPriority = 1;
  String selectedAssignee = ''; // Assignee user ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            // Add more fields (e.g., due date, priority, assignee)
            ElevatedButton(
              onPressed: () {
                // Create and save the task
                Navigator.pop(context);
              },
              child: Text('Create Task'),
            ),
          ],
        ),
      ),
    );
  }
}
