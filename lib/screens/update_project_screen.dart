// screens/update_project_screen.dart
import 'package:flutter/material.dart';
import 'package:task_management/models/project.dart';

class UpdateProjectScreen extends StatefulWidget {
  final Project project;

  UpdateProjectScreen({required this.project});

  @override
  _UpdateProjectScreenState createState() => _UpdateProjectScreenState();
}

class _UpdateProjectScreenState extends State<UpdateProjectScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late DateTime _dueDate;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing project details
    _nameController.text = widget.project.name;
    _descriptionController.text = widget.project.description;
    _dueDate = widget.project.dueDate;
  }

  void _updateProject() {
    // Extract updated project details from controllers
    String updatedName = _nameController.text;
    String updatedDescription = _descriptionController.text;

    // Create a new Project object with updated details
    Project updatedProject = Project(
      name: updatedName,
      description: updatedDescription,
      dueDate: _dueDate,
      tasks: widget.project.tasks, id: '', // Assuming you want to keep the existing tasks
    );

    // TODO: Implement logic to update the project in your data storage
    // For example, if using Firestore, you might call a function like:
    // updateProjectInFirestore(widget.project.id, updatedProject);

    // Pop the screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
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
                      initialDate: _dueDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != _dueDate) {
                      setState(() {
                        _dueDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    "${_dueDate.toLocal()}".split(' ')[0],
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateProject,
              child: Text('Update Project'),
            ),
          ],
        ),
      ),
    );
  }
}
