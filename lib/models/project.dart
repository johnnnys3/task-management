// models/project.dart
import 'package:cloud_firestore/cloud_firestore.dart';
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
  factory Project.fromMap(Map<String, dynamic> map, String id) {
    return Project(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      tasks: List<Task>.from(map['tasks'].map((task) => Task.fromMap(task))), // Convert each task map to a Task object
    );
  }


   factory Project.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Project(
      id: snapshot.id,
      name: data['name'],
      description: data['description'],
      dueDate: DateTime.parse(data['dueDate']),
      tasks: List<Task>.from(data['tasks'].map((task) => Task.fromMap(task))),
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
