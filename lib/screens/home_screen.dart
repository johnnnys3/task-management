import 'package:flutter/material.dart';
import 'package:task_management/screens/calendar_integration_screen.dart';
import 'package:task_management/screens/dashboard_screen.dart';
import 'package:task_management/screens/notification_screen.dart';
import 'package:task_management/screens/project_management_screen.dart';
import 'package:task_management/screens/reporting_screen.dart';
import 'package:task_management/screens/search_screen.dart';
import 'package:task_management/screens/task_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management',
      home: HomeScreen(userId: ''),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String userId;

  HomeScreen({required this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Task Management'),
          actions: [
            _buildIconButton(Icons.notifications, 'notification'),
            _buildIconButton(Icons.calendar_today, 'calendar'),
            _buildIconButton(Icons.assignment, 'taskList'),
            _buildIconButton(Icons.business, 'projectManagement'),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.insert_chart)),
              Tab(icon: Icon(Icons.dashboard)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ReportingScreen(),
            DashboardScreen(),
          ],
        ),
      ),
    );
  }

  IconButton _buildIconButton(IconData icon, String routeName) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => _buildRoute(routeName)),
        );
      },
    );
  }

  Widget _buildRoute(String routeName) {
    switch (routeName) {
      case 'notification':
        return NotificationScreen();
      case 'calendar':
        return CalendarIntegrationScreen();
      case 'taskList':
        return TaskListScreen(userId: widget.userId, tasks: []);
      case 'projectManagement':
        return ProjectManagementScreen(userId: '');
      default:
        return Scaffold(
          appBar: AppBar(title: Text('Error')),
          body: Center(child: Text('Invalid route name')),
        );
    }
  }
}
