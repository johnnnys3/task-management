import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/data/database_helper(task).dart';

class DashboardScreen extends StatelessWidget {
  final TaskDatabase taskDatabase = TaskDatabase();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: taskDatabase.fetchTasks(),
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No tasks available.');
        } else {
          List<Task>? tasks = snapshot.data;

          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Dashboard'),
                  backgroundColor: Colors.black, // Set app bar background color to black
                ),
                body: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Task Overview',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange), // Set text color to orange
                          ),
                          SizedBox(height: 20),
                          _buildTaskStats(tasks!),
                          SizedBox(height: 20),
                          Text(
                            'Upcoming Deadlines',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange), // Set text color to orange
                          ),
                          SizedBox(height: 10),
                          _buildUpcomingDeadlines(tasks),
                          SizedBox(height: 20),
                          Text(
                            'Task Completion Progress',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange), // Set text color to orange
                          ),
                          SizedBox(height: 10),
                          _buildTaskCompletionProgress(),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildTaskStats(List<Task> tasks) {
    int totalTasks = tasks.length;
    int completedTasks = tasks.where((task) => task.isCompleted).length;
    int pendingTasks = totalTasks - completedTasks;

    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.assignment_turned_in, color: Colors.green),
          title: Text('Completed Tasks'),
          trailing: Text('$completedTasks', style: TextStyle(color: Colors.white)), // Set text color to white
        ),
        ListTile(
          leading: Icon(Icons.assignment_late, color: Colors.red),
          title: Text('Pending Tasks'),
          trailing: Text('$pendingTasks', style: TextStyle(color: Colors.white)), // Set text color to white
        ),
        ListTile(
          leading: Icon(Icons.assignment, color: Colors.blue),
          title: Text('Total Tasks'),
          trailing: Text('$totalTasks', style: TextStyle(color: Colors.white)), // Set text color to white
        ),
      ],
    );
  }

  Widget _buildUpcomingDeadlines(List<Task> tasks) {
    List<Task> upcomingTasks = tasks.where((task) => task.hasDueDate).toList();

    return Column(
      children: upcomingTasks.map((task) {
        return ListTile(
          title: Text(task.title, style: TextStyle(color: Colors.white)), // Set text color to white
          subtitle: Text('Due Date: ${task.dueDate}', style: TextStyle(color: Colors.white)), // Set text color to white
        );
      }).toList(),
    );
  }

  Widget _buildTaskCompletionProgress() {
    // Add your logic for task completion progress here
    return Text('Task Completion: Placeholder%', style: TextStyle(color: Colors.white)); // Set text color to white
  }
}
