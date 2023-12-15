// models/project.dart
import 'package:task_management/models/task.dart'; // Import the Task model

class Project {
  final String id; // Include the id property
  final String name;
  final String description;
  final DateTime dueDate;
  final List<Task> tasks; // List of Task objects associated with the project

  Project({
    required this.id, // Include the id property
    required this.name,
    required this.description,
    required this.dueDate,
    required this.tasks,
  });

  // Add the fromMap factory method to convert from Map to Project
  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      tasks: List<Task>.from(map['tasks'].map((task) => Task.fromMap(task))), // Convert each task map to a Task object
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'tasks': tasks.map((task) => task.toMap()).toList(), // Convert each Task object to a map
    };
  }
}
