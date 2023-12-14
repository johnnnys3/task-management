import 'package:flutter/material.dart';
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
              DataTable(
                columns: [
                  DataColumn(label: Text('Task Status')),
                  DataColumn(label: Text('Count')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('Total Tasks')),
                    DataCell(Text('$_totalTasks')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Completed Tasks')),
                    DataCell(Text('$_completedTasks')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Pending Tasks')),
                    DataCell(Text('$_pendingTasks')),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
