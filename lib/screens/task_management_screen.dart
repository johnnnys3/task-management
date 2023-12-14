// screens/task_management_screen.dart
import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/screens/task_details_screen.dart';
import 'package:task_management/screens/notification_screen.dart';
import 'package:task_management/screens/collaboration_screen.dart';
import 'package:task_management/screens/search_screen.dart';
import 'package:task_management/screens/dashboard_screen.dart';
import 'package:task_management/screens/reporting_screen.dart';
import 'package:task_management/screens/calendar_screen.dart';
import 'package:task_management/screens/messaging_screen.dart';
import 'package:task_management/screens/calendar_integration_screen.dart';

class TaskManagementScreen extends StatefulWidget {
  final String userId;

  TaskManagementScreen({required this.userId});

  @override
  _TaskManagementScreenState createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  List<Task> tasks = []; // Populate this list with tasks from Firestore or another database

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
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarScreen()),
              );
            },
          ),
             IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: TaskSearchDelegate(tasks));
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // Implement filter logic based on the selected value
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
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the task creation screen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TaskSearchDelegate extends SearchDelegate<String> {
  final List<Task> tasks;

  TaskSearchDelegate(this.tasks);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search logic
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Task> suggestionList = tasks.where((task) => task.title.contains(query)).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(suggestionList[index].title),
            onTap: () {
              // Navigate to task details
            },
          ),
        );
      },
    );
  }
}