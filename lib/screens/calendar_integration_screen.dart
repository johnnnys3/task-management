import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_management/models/task.dart'; // Import your Task model
import 'package:task_management/data/database_helper.dart'; // Import your TaskDatabase class

class CalendarIntegrationScreen extends StatefulWidget {
  @override
  _CalendarIntegrationScreenState createState() => _CalendarIntegrationScreenState();
}

class _CalendarIntegrationScreenState extends State<CalendarIntegrationScreen> {
  DateTime _selectedDay = DateTime.now();
  final TaskDatabase taskDatabase = TaskDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            focusedDay: _selectedDay,
            firstDay: DateTime(2023, 1, 1),
            lastDay: DateTime(2023, 12, 31),
          ),
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<Task>>(
              // Fetch tasks from the database for the selected day
              future: taskDatabase.fetchTasksForDate(_selectedDay),
              builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Display a loading indicator while data is being fetched
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Handle error case
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // Handle case where no tasks are available for the selected day
                  return Text('No tasks available for the selected day.');
                } else {
                  // Display the tasks for the selected day
                  List<Task>? tasks = snapshot.data;

                  return ListView.builder(
                    itemCount: tasks!.length,
                    itemBuilder: (context, index) {
                      Task task = tasks[index];
                      return ListTile(
                        title: Text(task.title),
                        subtitle: Text('Due Date: ${task.dueDate}'),
                        // Add additional details as needed
                        // You can also add buttons to mark tasks as completed or delete them
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
