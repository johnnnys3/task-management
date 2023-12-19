import 'package:flutter/material.dart';

import 'package:task_management/authentication/user.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/screens/task_details_screen.dart';
import 'package:task_management/screens/task_creation_screen.dart';
import 'package:task_management/screens/update_task_screen.dart';
import 'package:task_management/service/task_service.dart'; // Import your actual task service

class TaskListScreen extends StatefulWidget {
  final String userId;
  final CustomUser user; // Pass the user information
  final bool isAdmin;

  TaskListScreen({required this.userId, required this.user, required this.isAdmin, required List tasks});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> with AutomaticKeepAliveClientMixin {
  List<Task> tasks = [];
  TaskService taskService = TaskService(); // Replace with your actual task service

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Initialize tasks from the database
    loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      List<Task> loadedTasks = await taskService.getTasks(userId: widget.userId);
      setState(() {
        tasks = loadedTasks;
      });
    } catch (e) {
      print('Error loading tasks: $e');
      // Handle error loading tasks
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
            onUpdateTask: widget.isAdmin ? (task) => navigateToUpdateTaskScreen(task) : null,
            onDeleteTask: widget.isAdmin ? (task) => deleteTask(task) : null,
          );
        },
      ),
      floatingActionButton: widget.isAdmin
          ? FloatingActionButton(
              onPressed: () async {
                Task? newTask = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskCreationScreen()),
                );

                if (newTask != null) {
                  addTask(newTask);
                }
              },
              child: Icon(Icons.add),
            )
          : null,
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

  void addTask(Task newTask) async {
    try {
      // Add the new task to the database
      await taskService.addTask(userId: widget.userId, task: newTask);

      // Reload tasks from the database
      await loadTasks();
    } catch (e) {
      print('Error adding task: $e');
      // Handle error adding task
    }
  }

  void deleteTask(Task task) async {
    try {
      // Delete the task from the database
      await taskService.deleteTask(userId: widget.userId, taskId: task.id as String);

      // Reload tasks from the database
      await loadTasks();
    } catch (e) {
      print('Error deleting task: $e');
      // Handle error deleting task
    }
  }
}

class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback onTaskTap;
  final Function(Task)? onUpdateTask;
  final Function(Task)? onDeleteTask;

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
        if (onUpdateTask != null || onDeleteTask != null) {
          _showTaskOptionsDialog(context);
        }
      },
    );
  }

  void _showTaskOptionsDialog(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(0, 0, 0, 0),
      items: [
        if (onUpdateTask != null)
          PopupMenuItem(
            value: 'update',
            child: ListTile(
              title: Text('Update Task'),
              onTap: () {
                Navigator.pop(context);
                onUpdateTask!(task);
              },
            ),
          ),
        if (onDeleteTask != null)
          PopupMenuItem(
            value: 'delete',
            child: ListTile(
              title: Text('Delete Task'),
              onTap: () {
                Navigator.pop(context);
                onDeleteTask!(task);
              },
            ),
          ),
      ],
    );
  }
}
