import 'package:flutter/material.dart';
import 'package:task_management/data/database_helper(project).dart';
import 'package:task_management/models/project.dart';
 // Import your ProjectDatabase

class CreateProjectScreen extends StatefulWidget {
  @override
  _CreateProjectScreenState createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController projectDescriptionController = TextEditingController();
  DateTime selectedDueDate = DateTime.now();

  void _createProject(BuildContext context) async {
    // Validate input fields
    if (projectNameController.text.isEmpty) {
      // Show an error message or toast
      return;
    }

    // Create a new project
    Project newProject = Project(
      name: projectNameController.text,
      description: projectDescriptionController.text,
      dueDate: selectedDueDate, 
      tasks: [], 
      id: '',
      // Add other fields as needed
    );

    try {
      // Save the project to the database
      await ProjectDatabase().addProject(newProject);
      // Navigate back to the previous screen
      Navigator.pop(context, newProject);
    } catch (e) {
      // Handle errors, e.g., show a snackbar or display an error message
      print('Error creating project: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Project'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: projectNameController,
              decoration: InputDecoration(labelText: 'Project Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: projectDescriptionController,
              decoration: InputDecoration(labelText: 'Project Description'),
            ),
            SizedBox(height: 16),
            // Due Date Picker
            Row(
              children: [
                Text('Due Date: '),
                SizedBox(width: 8),
                TextButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDueDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != selectedDueDate) {
                      setState(() {
                        selectedDueDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    "${selectedDueDate.toLocal()}".split(' ')[0],
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _createProject(context);
              },
              child: Text('Create Project'),
            ),
          ],
        ),
      ),
    );
  }
}
