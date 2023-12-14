import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart'; // Replace with the actual path

// ignore: must_be_immutable
class UpdateTaskScreen extends StatefulWidget {
  Task task;

  UpdateTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  _UpdateTaskScreenState createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter task title',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter task description',
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Implement logic to update the task
                updateTask();
              },
              child: Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }

  void updateTask() {
    // Retrieve the new values from the text controllers
    String updatedTitle = titleController.text;
    String updatedDescription = descriptionController.text;

    // Create a new Task instance with updated values
    Task updatedTask = Task(
      title: updatedTitle,
      description: updatedDescription,
      dueDate: widget.task.dueDate,
      priority: widget.task.priority,
      attachments: widget.task.attachments,
      assignedTo: widget.task.assignedTo,
    );

    // Update the existing task in the widget's state
    setState(() {
      widget.task = updatedTask;
    });

    // TODO: Save the updated task to the database or use your state management solution
    // Example: taskService.updateTask(widget.task);

    // Navigate back to the task details screen or task list with the updated task
    Navigator.pop(context, widget.task);
  }
}
