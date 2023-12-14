// screens/calendar_integration_screen.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';



class CalendarIntegrationScreen extends StatefulWidget {
 @override
 _CalendarIntegrationScreenState createState() => _CalendarIntegrationScreenState();
}

class _CalendarIntegrationScreenState extends State<CalendarIntegrationScreen> {
 late CalendarController _calendarController;

 @override
 void initState() {
    super.initState();
    _calendarController = CalendarController();
 }

 @override
 void dispose() {
    _calendarController.dispose();
    super.dispose();
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Integration'),
      ),
      body: TableCalendar(
        calendarController: _calendarController,
        // Add more configuration as needed
        focusedDay: DateTime.now(),
        firstDay: DateTime(2023, 1, 1),
        lastDay: DateTime(2023, 12, 31),
      ),
    );
 }
}