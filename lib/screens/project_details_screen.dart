// project_details_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/authentication/authentication_service.dart';
import 'package:task_management/authentication/user.dart';
import 'package:task_management/models/project.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/screens/task_list_screen.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final Project project;

  ProjectDetailsScreen({required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Name: ${project.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Project Description: ${project.description}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _navigateToTasksScreen(context, project.tasks);
              },
              child: Text('View Tasks'),
            ),
            // Add more details or features as needed
          ],
        ),
      ),
    );
  }

  void _navigateToTasksScreen(BuildContext context, List<Task> tasks) {
    AuthenticationService authService = Provider.of<AuthenticationService>(context, listen: false);
    CustomUser currentUser = authService.currentUser!; // Assuming currentUser is non-nullable

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TasksScreen(tasks: tasks, authService: authService, user: currentUser),
      ),
    );
  }
}




class TasksScreen extends StatelessWidget {
  final List<Task> tasks;
  final AuthenticationService authService;
  final CustomUser user;

  TasksScreen({required this.tasks, required this.authService, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Tasks'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].title),
            onTap: () {
              _navigateToTaskDetailsScreen(context, tasks[index]);
            },
          );
        },
      ),
    );
  }

  void _navigateToTaskDetailsScreen(BuildContext context, Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskListScreen(
          userId: authService.currentUser?.uid ?? '',
          tasks: [task],
          isAdmin: authService.isAdmin,
          user: user,
        ),
      ),
    );
  }
}


