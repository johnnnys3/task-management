
import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/service/task_service.dart';

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
    String updatedTitle = titleController.text;
    String updatedDescription = descriptionController.text;

    Task updatedTask = Task(
      id: widget.task.id,
      title: updatedTitle,
      description: updatedDescription,
      dueDate: widget.task.dueDate,
      attachments: widget.task.attachments,
      assignedTo: widget.task.assignedTo,
      isCompleted: widget.task.isCompleted,
      associatedProject: widget.task.associatedProject,
    );

    setState(() {
      widget.task = updatedTask;
    });

    TaskService taskService = TaskService();
    await taskService.updateTask( task: widget.task, taskId: '');


    Navigator.pop(context, widget.task);
  }
}
