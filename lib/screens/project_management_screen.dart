
import 'package:flutter/material.dart';
import 'package:task_management/authentication/user.dart';
import 'package:task_management/models/project.dart' as TaskProject; // Using 'as' to create a prefix
import 'package:task_management/screens/project_details_screen.dart';
import 'package:task_management/screens/create_project_screen.dart';
import 'package:task_management/screens/update_project_screen.dart';
import 'package:task_management/service/project_service.dart';

class ProjectManagementScreen extends StatefulWidget {
  final String userId;
  final CustomUser user; // Pass the user information
  final bool isAdmin;

  ProjectManagementScreen({required this.userId, required this.user, required this.isAdmin});

  @override
  _ProjectManagementScreenState createState() => _ProjectManagementScreenState();
}

class _ProjectManagementScreenState extends State<ProjectManagementScreen> with AutomaticKeepAliveClientMixin {
  List<TaskProject.Project> projects = []; // Populate this list with projects from Firestore or another database

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Initialize projects from the database
    loadProjects();
  }

  Future<void> loadProjects() async {
  try {
    // Create an instance of ProjectService
    ProjectService projectService = ProjectService();

    // Fetch projects using the instance
    List<TaskProject.Project> loadedProjects = (await projectService.getProjects(userId: widget.userId)).cast<TaskProject.Project>();

    // Explicitly cast to the correct type
    setState(() {
      projects = loadedProjects;
    });
  } catch (e) {
    print('Error loading projects: $e');
    // Handle error loading projects
  }
}

  @override
  Widget build(BuildContext context) {
    super.build(context); // Make sure to call super.build

    return Scaffold(
      appBar: AppBar(
        title: Text('Project Management'),
        backgroundColor: Colors.orange,
      ),
      body: _buildProjectList(),
      floatingActionButton: widget.isAdmin ? _buildFloatingActionButton() : null,
    );
  }

  Widget _buildProjectList() {
    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            projects[index].name,
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            _navigateToProjectDetailsScreen(projects[index]);
          },
          onLongPress: () {
            if (widget.isAdmin) {
              _showOptionsDialog(projects[index]);
            }
          },
        );
      },
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        _navigateToCreateProjectScreen();
      },
      tooltip: 'Create Project',
      child: Icon(Icons.add),
      backgroundColor: Colors.orange,
    );
  }

  void _navigateToCreateProjectScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateProjectScreen(),
      ),
    );

    if (result != null && result is TaskProject.Project) {
      // Handle the newly created project, e.g., add it to the list
      setState(() {
        projects.add(result);
      });
    }
  }

  void _navigateToProjectDetailsScreen(TaskProject.Project project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectDetailsScreen(project: project),
      ),
    );
  }

  void _showOptionsDialog(TaskProject.Project project) {
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

  void _editProject(TaskProject.Project project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProjectScreen(project: project),
      ),
    );
  }

  void _deleteProject(TaskProject.Project project) {
    // Implement the logic to delete the project, e.g., remove it from the list
    setState(() {
      projects.remove(project);
    });
  }
}