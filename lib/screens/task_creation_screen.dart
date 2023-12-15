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
  String selectedAssignee = ''; // Assignee user ID

  // Counter to keep track of the last assigned ID
  int _lastId = 0;

  // Mock function to simulate fetching assignee details from the company database
  Future<String> fetchAssigneeDetails() async {
    // Simulate an asynchronous call (replace this with your actual implementation)
    await Future.delayed(Duration(seconds: 2));
    return 'Assignee from Company Database';
  }

  void _createTask(BuildContext context) async {
    // Increment the counter for a new unique ID
    _lastId++;

    // Fetch assignee details asynchronously
    String assigneeDetails = await fetchAssigneeDetails();

    // Create the task
    Task newTask = Task(
      id: _lastId,
      title: titleController.text,
      description: descriptionController.text,
      dueDate: selectedDueDate,
      assignedTo: assigneeDetails,
      attachments: [],
      isCompleted: false, // Set the initial completion status to false
      associatedProject: null, // Set the associated project to null initially
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16),
            // Due Date Picker
            Row(
              children: [
                Text('Due Date: '),
                SizedBox(width: 8),
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
            SizedBox(height: 16),
            // Display the selected assignee
            Text('Assignee: $selectedAssignee'),
            SizedBox(height: 16),
            // Add UI elements for isCompleted and associatedProject
            CheckboxListTile(
              title: Text('Completed'),
              value: false, // Set the initial value (modify as needed)
              onChanged: (value) {
                // Handle completion status change
              },
            ),
            // UI for selecting the associated project can be added here
            SizedBox(height: 16),
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
