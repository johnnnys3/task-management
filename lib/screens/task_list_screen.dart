// screens/task_list_screen.dart
import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/screens/task_details_screen.dart';
import 'package:task_management/screens/task_creation_screen.dart';
import 'package:task_management/screens/update_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  final String userId;

  TaskListScreen({required this.userId});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = []; // Populate this list with tasks from Firestore or another database

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskListItem(
            task: tasks[index],
            onTaskTap: () {
              navigateToTaskDetailsScreen(tasks[index]);
            },
            onUpdateTask: (task) {
              navigateToUpdateTaskScreen(task);
            },
            onDeleteTask: (task) {
              deleteTask(task);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Task? newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskCreationScreen()),
          );

          if (newTask != null) {
            setState(() {
              tasks.add(newTask);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void navigateToTaskDetailsScreen(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskDetailsScreen(task: task)),
    );
  }

  void navigateToUpdateTaskScreen(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateTaskScreen(task: task)),
    );
  }

  void deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
    // You may also want to delete the task from the database if applicable
  }
}

class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback onTaskTap;
  final Function(Task) onUpdateTask;
  final Function(Task) onDeleteTask;

  TaskListItem({
    required this.task,
    required this.onTaskTap,
    required this.onUpdateTask,
    required this.onDeleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      onTap: onTaskTap,
      onLongPress: () {
        _showTaskOptionsDialog(context);
      },
    );
  }

  void _showTaskOptionsDialog(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(0, 0, 0, 0),
      items: [
        PopupMenuItem(
          value: 'update',
          child: ListTile(
            title: Text('Update Task'),
            onTap: () {
              Navigator.pop(context);
              onUpdateTask(task);
            },
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: ListTile(
            title: Text('Delete Task'),
            onTap: () {
              Navigator.pop(context);
              onDeleteTask(task);
            },
          ),
        ),
      ],
    );
  }
}
