import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportingScreen extends StatefulWidget {
  @override
  _ReportingScreenState createState() => _ReportingScreenState();
}

class _ReportingScreenState extends State<ReportingScreen> {
  int _totalTasks = 0;
  int _completedTasks = 0;
  int _pendingTasks = 0;

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    final tasks = await FirebaseFirestore.instance.collection('tasks').get();
    final List<DocumentSnapshot> docs = tasks.docs;

    setState(() {
      _totalTasks = docs.length;
      _completedTasks = docs.where((doc) => doc['isCompleted'] == true).length;
      _pendingTasks = docs.where((doc) => doc['isCompleted'] == false).length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reporting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task Report',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            DataTable(
              columns: [
                DataColumn(label: Text('Tasks')),
                DataColumn(label: Text('Count')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('Total Tasks', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text('$_totalTasks', style: TextStyle(fontWeight: FontWeight.bold))),
                ]),
                DataRow(cells: [
                  DataCell(Text('Completed Tasks', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green))),
                  DataCell(Text('$_completedTasks', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green))),
                ]),
                DataRow(cells: [
                  DataCell(Text('Pending Tasks', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))),
                  DataCell(Text('$_pendingTasks', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
