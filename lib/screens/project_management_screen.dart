// screens/project_management_screen.dart
import 'package:flutter/material.dart';
import 'package:task_management/models/project.dart';

class ProjectManagementScreen extends StatefulWidget {
  final String userId;

  ProjectManagementScreen({required this.userId});

  @override
  _ProjectManagementScreenState createState() => _ProjectManagementScreenState();
}

class _ProjectManagementScreenState extends State<ProjectManagementScreen> {
  List<Project> projects = []; // Populate this list with projects from Firestore or another database

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Management'),
      ),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(projects[index].name),
            onTap: () {
              // Handle project details or updates
            },
          );
        },
      ),
    );
  }
}
