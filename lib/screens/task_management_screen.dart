// Import necessary packages and classes
import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/screens/task_creation_screen.dart';
import 'package:task_management/screens/task_details_screen.dart';
import 'package:task_management/screens/notification_screen.dart';
import 'package:task_management/screens/collaboration_screen.dart';
import 'package:task_management/screens/dashboard_screen.dart';
import 'package:task_management/screens/reporting_screen.dart';
import 'package:task_management/screens/messaging_screen.dart';
import 'package:task_management/screens/calendar_integration_screen.dart';
import 'package:task_management/screens/update_task_screen.dart';

class TaskManagementScreen extends StatefulWidget {
  final String userId;

  TaskManagementScreen({required this.userId});

  @override
  _TaskManagementScreenState createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  List<Task> tasks = [
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.dashboard),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportingScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.group),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CollaborationScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MessagingScreen(userId: widget.userId)),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarIntegrationScreen()),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // Implement filter logic based on the selected value
              filterTasks(value);
            },
            itemBuilder: (BuildContext context) {
              return ['Filter 1', 'Filter 2', 'Filter 3'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(tasks[index].title),
              subtitle: Text(tasks[index].description),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetailsScreen(task: tasks[index]),
                  ),
                );
              },
              onLongPress: () {
                // Show options for task update or deletion
                showTaskOptionsDialog(context, tasks[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the task creation screen
          navigateToTaskCreationScreen();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void filterTasks(String filterValue) {
    // Implement logic to filter tasks based on the selected value
    // Update the 'tasks' list accordingly
    setState(() {
      // Update 'tasks' based on the filterValue
      // tasks = ... updated task list;
    });
  }

  void showTaskOptionsDialog(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Task Options"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text("Update Task"),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  // Navigate to the screen for updating the task
                  navigateToUpdateTaskScreen(task);
                },
              ),
              ListTile(
                title: Text("Delete Task"),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  // Implement logic to delete the task
                  deleteTask(task);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void navigateToTaskCreationScreen() {
    // Implement navigation logic to the task creation screen
    Navigator.push(context, MaterialPageRoute(builder: (context) => TaskCreationScreen()));
  }

  void navigateToUpdateTaskScreen(Task task) {
    // Implement navigation logic to the update task screen
    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateTaskScreen(task: task)));
  }

  void deleteTask(Task task) {
    // Implement logic to delete the task from the 'tasks' list or database
    setState(() {
      tasks.remove(task);
    });
    // You may also want to delete the task from the database if applicable
  }
}
