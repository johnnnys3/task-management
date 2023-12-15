// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:task_management/screens/task_list_screen.dart';
import 'package:task_management/screens/notification_screen.dart';
import 'package:task_management/screens/dashboard_screen.dart';
import 'package:task_management/screens/reporting_screen.dart';
import 'package:task_management/screens/collaboration_screen.dart';
import 'package:task_management/screens/messaging_screen.dart';
import 'package:task_management/screens/calendar_integration_screen.dart';
import 'package:task_management/screens/project_management_screen.dart'; 

class HomeScreen extends StatefulWidget {
  final String userId; // Assume the user ID is passed from the authentication process

  HomeScreen({required this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = 'All'; // Default filter

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
          // Added Task Management IconButton
          IconButton(
            icon: Icon(Icons.assignment),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskListScreen(userId: widget.userId),
                ),
              );
            },
          ),
          // Added Project Management IconButton
          IconButton(
            icon: Icon(Icons.business),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectManagementScreen(userId: '',), // Replace ProjectManagementScreen with your actual screen
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                selectedFilter = value;
              });
              filterTasks(selectedFilter);
            },
            itemBuilder: (BuildContext context) {
              return ['All', 'Filter 1', 'Filter 2', 'Filter 3'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Task Manager!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Add more content or buttons for other features/screens
          ],
        ),
      ),
    );
  }

  void filterTasks(String selectedValue) {
    // Implement your filter logic here
    // For demonstration, let's print the selected filter
    print('Selected Filter: $selectedValue');

    // You can update a variable or perform actions based on the selected filter
    // For example, update a list of tasks based on the filter
    // Or, trigger a network request with the selected filter
  }
}
