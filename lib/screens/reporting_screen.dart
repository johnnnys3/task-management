import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:task_management/data/database_helper.dart';


class ReportingScreen extends StatefulWidget {
 @override
 _ReportingScreenState createState() => _ReportingScreenState();
}

class _ReportingScreenState extends State<ReportingScreen> {
 int _totalTasks = 0;
 int _completedTasks = 0;
 int _pendingTasks = 0;

 Future<void> _fetchTasks() async {
    final tasks = await DatabaseHelper.instance.fetchTasks();
    setState(() {
      _totalTasks = tasks.length;
      _completedTasks = tasks.where((task) => task.isCompleted).length;
      _pendingTasks = tasks.where((task) => !task.isCompleted).length;
    });
 }

 @override
 void initState() {
    super.initState();
    _fetchTasks();
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reporting'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                child: PieChart(
                 PieChartData(
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 0,
                    sections: [
                      PieChartSectionData(
                        color: Color(0xFF4caf50),
                        value: _completedTasks.toDouble(),
                        title: 'Completed',
                        radius: 120,
                        titleStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4caf50),
                        ),
                      ),
                      PieChartSectionData(
                        color: Color(0xFFffeb3b),
                        value: _pendingTasks.toDouble(),
                        title: 'Pending',
                        radius: 120,
                        titleStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFffeb3b),
                        ),
                      ),
                    ],
                 ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Total Tasks: $_totalTasks',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Completed Tasks: $_completedTasks',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Pending Tasks: $_pendingTasks',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
 }
}