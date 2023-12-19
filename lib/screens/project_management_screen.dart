import 'package:flutter/material.dart';
import 'package:task_management/models/project.dart';
import 'package:task_management/screens/project_details_screen.dart';
import 'package:task_management/screens/create_project_screen.dart';
import 'package:task_management/screens/update_project_screen.dart';

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
        backgroundColor: Colors.orange, // Set your desired app bar background color to orange
      ),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              projects[index].name,
              style: TextStyle(color: Colors.black), // Set text color to black
            ),
            onTap: () {
              _navigateToProjectDetailsScreen(projects[index]);
            },
            onLongPress: () {
              _showOptionsDialog(projects[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToCreateProjectScreen();
        },
        tooltip: 'Create Project',
        child: Icon(Icons.add),
        backgroundColor: Colors.orange, // Set FAB background color to orange
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProjectScreen(project: project),
      ),
    );
  }

  void _deleteProject(Project project) {
    // Implement the logic to delete the project, e.g., remove it from the list
    setState(() {
      projects.remove(project);
    });
  }
}
