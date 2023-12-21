import 'package:flutter/material.dart';
import 'package:task_management/models/project.dart';
import 'package:intl/intl.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final Project project;

  ProjectDetailsScreen({required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Project Name: ${project.name}'),
          ),
          ListTile(
            title: Text('Project Description: ${project.description}'),
          ),
          ListTile(
            title: Text('Due Date: ${_formattedDate(project.dueDate)}'),
          ),
          ListTile(
            title: Text('Status: ${project.isCompleted ? 'Completed' : 'Pending'}'),
          ),
          ListTile(
            title: Text('Tasks: ${project.tasks.length}'),
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
