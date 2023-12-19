import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_management/data/database_helper(task).dart';
import 'package:task_management/models/task.dart';

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
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: taskDatabase.fetchTasksForDate(_selectedDay),
              builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No tasks available for the selected day.');
                } else {
                  List<Task>? tasks = snapshot.data;

                  return ListView.builder(
                    itemCount: tasks!.length,
                    itemBuilder: (context, index) {
                      Task task = tasks[index];
                      return ListTile(
                        title: Text(task.title),
                        subtitle: Text('Due Date: ${task.dueDate}'),
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
