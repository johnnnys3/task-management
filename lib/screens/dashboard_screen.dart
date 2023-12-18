import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/data/database_helper(task).dart';// Import your TaskDatabase class

class DashboardScreen extends StatelessWidget {
  final TaskDatabase taskDatabase = TaskDatabase(); // Instantiate your TaskDatabase

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      // Fetch tasks from the database
      future: taskDatabase.fetchTasks(),
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while data is being fetched
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle error case
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Handle case where no tasks are available
          return Text('No tasks available.');
        } else {
          // Display the dashboard using data from the database
          List<Task>? tasks = snapshot.data;

          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Dashboard'),
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
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          _buildTaskStats(tasks!),
                          SizedBox(height: 20),
                          Text(
                            'Upcoming Deadlines',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          _buildUpcomingDeadlines(tasks),
                          SizedBox(height: 20),
                          Text(
                            'Task Completion Progress',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

  Widget _buildUpcomingDeadlines(List<Task> tasks) {
  List<Task> upcomingTasks = tasks.where((task) => task.hasDueDate).toList();

  return Column(
    children: upcomingTasks.map((task) {
      return ListTile(
        title: Text(task.title),
        subtitle: Text('Due Date: ${task.dueDate}'),
      );
    }).toList(),
  );
}

  Widget _buildTaskCompletionProgress() {
    // Add your logic for task completion progress here
    return Text('Task Completion: Placeholder%');
  }
}
