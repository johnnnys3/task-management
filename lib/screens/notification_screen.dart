import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart'; // Import the Task model
import 'package:task_management/data/database_helper.dart'; // Import your TaskDatabase class
import 'task_details_screen.dart'; // Import the screen where you want to show task details

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final TaskDatabase _taskDatabase = TaskDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: FutureBuilder<List<Task>>(
        // Fetch tasks from the database to simulate notifications
        future: _taskDatabase.fetchTasks(),
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while data is being fetched
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle error case
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Handle case where no tasks are available
            return Text('No notifications available.');
          } else {
            // Display a list of notifications based on tasks
            List<Task> tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                Task task = tasks[index];
                return ListTile(
                  title: Text('Task: ${task.title}'),
                  subtitle: Text('Due Date: ${task.dueDate}'),
                  onTap: () {
                    // Handle tapping on a notification
                    _navigateToTaskDetails(task);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  // Function to navigate to the Task Details screen
  void _navigateToTaskDetails(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailsScreen(task: task),
      ),
    );
  }
}
