import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart';

// Service class to interact with the database or state management
class TaskService {
  // Replace this with your actual database or state management logic
  Future<void> updateTask(Task task) async {
    // Your logic to update the task in the database or state management
    // For example, you might use an API call, SQL, or other storage mechanisms
    await Future.delayed(Duration(seconds: 2)); // Simulating an asynchronous operation

    print('Task updated in the database');
  }
}

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
              onPressed: () async {
                // Implement logic to update the task
                await updateTask();
              },
              child: Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateTask() async {
    // Retrieve the new values from the text controllers
    String updatedTitle = titleController.text;
    String updatedDescription = descriptionController.text;

    // Create a new Task instance with updated values
    Task updatedTask = Task(
      title: updatedTitle,
      description: updatedDescription,
      dueDate: widget.task.dueDate,
      
      attachments: widget.task.attachments,
      assignedTo: widget.task.assignedTo, 
      id: widget.task.id, 
      isCompleted: false, 
      associatedProject: null,
    );

    // Update the existing task in the widget's state
    setState(() {
      widget.task = updatedTask;
    });

    // Save the updated task to the database or use your state management solution
    TaskService taskService = TaskService();
    await taskService.updateTask(widget.task);

    // Navigate back to the task details screen or task list with the updated task
    Navigator.pop(context, widget.task);
  }
}
