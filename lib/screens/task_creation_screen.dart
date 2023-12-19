import 'package:flutter/material.dart';
import 'package:task_management/data/database_helper(task).dart';
import 'package:task_management/models/task.dart';

class TaskCreationScreen extends StatefulWidget {
  @override
  _TaskCreationScreenState createState() => _TaskCreationScreenState();
}

class _TaskCreationScreenState extends State<TaskCreationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime selectedDueDate = DateTime.now();
  bool isLoading = false;

  // Counter to keep track of the last assigned ID
  int _lastId = 0;

  // Mock function to simulate fetching assignee details from the work database
  Future<String> fetchAssigneeFromWorkDatabase() async {
    // Simulate an asynchronous call to your work database API
    // Replace this with your actual implementation
    await Future.delayed(Duration(seconds: 2));
    return 'Assignee from Work Database';
  }

  // Method to create a task
  void _createTask(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      // Increment the counter for a new unique ID
      _lastId++;

      // Fetch assignee details asynchronously
      String assigneeDetails = await fetchAssigneeFromWorkDatabase();

      // Create the task
      Task newTask = Task(
        id: _lastId.toString(),
        title: titleController.text,
        description: descriptionController.text,
        dueDate: selectedDueDate,
        assignedTo: assigneeDetails,
        attachments: [],
        isCompleted: false,
        associatedProject: null, // You might need to update this based on your project structure
      );

      try {
        // Save the task to the database
        await TaskDatabase().insertTask(newTask);

        // Optionally, you can print a success message
        print('Task created successfully.');

        // Navigate back to the previous screen
        Navigator.pop(context);
      } catch (e) {
        // Handle errors, e.g., show a snackbar or display an error message
        print('Error creating task: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred. Please try again.'),
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Widget to display the loading spinner
  Widget _buildLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // Method to show an error snackbar
  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task'),
      ),
      body: isLoading
          ? _buildLoadingWidget()
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
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
                            if (pickedDate != null &&
                                pickedDate != selectedDueDate) {
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
                    ElevatedButton(
                      onPressed: () {
                        _createTask(context);
                      },
                      child: Text('Create Task'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
