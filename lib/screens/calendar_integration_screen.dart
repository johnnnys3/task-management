// screens/calendar_integration_screen.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarIntegrationScreen extends StatefulWidget {
  @override
  _CalendarIntegrationScreenState createState() => _CalendarIntegrationScreenState();
}

class _CalendarIntegrationScreenState extends State<CalendarIntegrationScreen> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Integration'),
      ),
      body: TableCalendar(
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
          });
        },
        focusedDay: _selectedDay, // Provide the required focusedDay parameter
        firstDay: DateTime(2023, 1, 1),
        lastDay: DateTime(2023, 12, 31),
      ),
    );
  }
}
