import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildTaskStats(),
            SizedBox(height: 20),
            Text(
              'Upcoming Deadlines',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildUpcomingDeadlines(),
            SizedBox(height: 20),
            Text(
              'Task Completion Progress',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildTaskCompletionProgress(),
            SizedBox(height: 20),
            Text(
              'Upcoming Tasks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            
            // Add more widgets as needed for additional dashboard components
          ],
        ),
      ),
    );
  }

  Widget _buildTaskStats() {
    // Placeholder data - Replace this with actual data from your app
    int totalTasks = 100;
    int completedTasks = 75;
    int pendingTasks = totalTasks - completedTasks;

    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.assignment_turned_in, color: Colors.green),
          title: Text('Completed Tasks'),
          trailing: Text('$completedTasks'),
        ),
        ListTile(
          leading: Icon(Icons.assignment_late, color: Colors.red),
          title: Text('Pending Tasks'),
          trailing: Text('$pendingTasks'),
        ),
        ListTile(
          leading: Icon(Icons.assignment, color: Colors.blue),
          title: Text('Total Tasks'),
          trailing: Text('$totalTasks'),
        ),
      ],
    );
  }

  Widget _buildUpcomingDeadlines() {
    // Placeholder data - Replace this with actual data from your app
    List<Map<String, dynamic>> upcomingDeadlines = [
      {'task': 'Task 1', 'deadline': '2023-01-15'},
      {'task': 'Task 2', 'deadline': '2023-01-20'},
      {'task': 'Task 3', 'deadline': '2023-01-25'},
    ];

    return Column(
      children: upcomingDeadlines.map((deadline) {
        return ListTile(
          title: Text(deadline['task']),
          subtitle: Text('Deadline: ${deadline['deadline']}'),
        );
      }).toList(),
    );
  }

  Widget _buildTaskCompletionProgress() {
    // Placeholder data - Replace this with actual data from your app
    double completionPercentage = 0.75; // 75%

    return Column(
      children: [
        LinearProgressIndicator(
          value: completionPercentage,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
        SizedBox(height: 10),
        Text('Task Completion: ${(completionPercentage * 100).toStringAsFixed(2)}%'),
      ],
    );
  }



}
