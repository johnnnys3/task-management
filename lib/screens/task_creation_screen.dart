import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart';

class TaskCreationScreen extends StatefulWidget {
  @override
  _TaskCreationScreenState createState() => _TaskCreationScreenState();
}

class _TaskCreationScreenState extends State<TaskCreationScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime selectedDueDate = DateTime.now();
  int selectedPriority = 1;
  String selectedAssignee = ''; // Assignee user ID

  // Counter to keep track of the last assigned ID
  int _lastId = 0;

  // List of sample assignees for the dropdown
  List<String> assignees = ['Assignee 1', 'Assignee 2', 'Assignee 3'];

  void _createTask(BuildContext context) {
    // Increment the counter for a new unique ID
    _lastId++;

    // Create the task
    Task newTask = Task(
      id: _lastId,
      title: titleController.text,
      description: descriptionController.text,
      dueDate: selectedDueDate,
      assignedTo: selectedAssignee,
      attachments: [],
    );

    // Pass the new task back to the previous screen
    Navigator.pop(context, newTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            // Due Date Picker
            Row(
              children: [
                Text('Due Date: '),
                TextButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDueDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != selectedDueDate) {
                      setState(() {
                        selectedDueDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    "${selectedDueDate.toLocal()}".split(' ')[0],
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            // Assignee Dropdown
            DropdownButton<String>(
              value: selectedAssignee,
              onChanged: (String? newValue) {
                setState(() {
                  selectedAssignee = newValue!;
                });
              },
              items: assignees.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text('Select Assignee'),
            ),
            // Add more fields (e.g., priority, other fields)
            ElevatedButton(
              onPressed: () {
                _createTask(context);
              },
              child: Text('Create Task'),
            ),
          ],
        ),
      ),
    );
  }
}
