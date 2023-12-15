import 'package:flutter/material.dart';
import 'package:task_management/models/project.dart';
import 'package:task_management/screens/project_details_screen.dart';
import 'package:task_management/screens/create_project_screen.dart';

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
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _navigateToCreateProjectScreen();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(projects[index].name),
            onTap: () {
              _navigateToProjectDetailsScreen(projects[index]);
            },
            onLongPress: () {
              _showOptionsDialog(projects[index]);
            },
          );
        },
      ),
    );
  }

  void _navigateToCreateProjectScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateProjectScreen(),
      ),
    );

    if (result != null && result is Project) {
      // Handle the newly created project, e.g., add it to the list
      setState(() {
        projects.add(result);
      });
    }
  }

  void _navigateToProjectDetailsScreen(Project project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectDetailsScreen(project: project),
      ),
    );
  }

  void _showOptionsDialog(Project project) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Edit Project'),
                onTap: () {
                  Navigator.pop(context);
                  _editProject(project);
                },
              ),
              ListTile(
                title: Text('Delete Project'),
                onTap: () {
                  Navigator.pop(context);
                  _deleteProject(project);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _editProject(Project project) {
    // Implement the logic to edit the project, e.g., navigate to an edit screen
  }

  void _deleteProject(Project project) {
    // Implement the logic to delete the project, e.g., remove it from the list
    setState(() {
      projects.remove(project);
    });
  }
}
