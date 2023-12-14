import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:task_management/models/task.dart';

class ReportingScreen extends StatelessWidget {
  final List<Task> tasks;
  ReportingScreen({required this.tasks});

  @override
  Widget build(BuildContext context) {
    // Calculate some basic statistics
    int totalTasks = tasks.length;
    int completedTasks = tasks.where((task) => task.isCompleted).length;
    int pendingTasks = totalTasks - completedTasks;

    return Scaffold(
      appBar: AppBar(
        title: Text('Reporting'),
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
            SizedBox(height: 16),
            Text('Total Tasks: $totalTasks'),
            Text('Completed Tasks: $completedTasks'),
            Text('Pending Tasks: $pendingTasks'),
            SizedBox(height: 32),
            Text(
              'Task Status Distribution',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    color: Colors.green,
                    value: completedTasks.toDouble(),
                    title: 'Completed',
                  ),
                  PieChartSectionData(
                    color: Colors.red,
                    value: pendingTasks.toDouble(),
                    title: 'Pending',
                  ),
                ],
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                startDegreeOffset: 180,
                borderData: FlBorderData(show: false),
                
                sectionsTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                centerSpaceColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
