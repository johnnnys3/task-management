// models/project.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management/models/task.dart';

class Project {
  final String id;
  final String name;
  final String description;
  final DateTime dueDate;
  final List<Task> tasks;
  final bool isCompleted; // New property

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.dueDate,
    required this.tasks,
    required this.isCompleted, // Include the isCompleted property
  });

  factory Project.fromMap(Map<String, dynamic> map, String id) {
    return Project(
      id: id,
      name: map['name'],
      description: map['description'],
      dueDate: map['dueDate'] is Timestamp
          ? (map['dueDate'] as Timestamp).toDate()
          : DateTime.parse(map['dueDate'] as String),
      tasks: List<Task>.from(map['tasks'].map((task) => Task.fromMap(task))),
      isCompleted: map['isCompleted'] ?? false, // Include the isCompleted property
    );
  }

  factory Project.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    dynamic dueDateData = data['dueDate'];
    DateTime dueDate;

    if (dueDateData is String) {
      dueDate = DateTime.parse(dueDateData);
    } else if (dueDateData is Timestamp) {
      dueDate = dueDateData.toDate();
    } else {
      throw ArgumentError('Unexpected type for dueDate');
    }

    return Project(
      id: snapshot.id,
      name: data['name'],
      description: data['description'],
      dueDate: dueDate,
      tasks: List<Task>.from(data['tasks'].map((task) => Task.fromMap(task))),
      isCompleted: data['isCompleted'] ?? false, // Include the isCompleted property
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'dueDate': Timestamp.fromDate(dueDate),
      'tasks': tasks.map((task) => task.toMap()).toList(),
      'isCompleted': isCompleted, // Include the isCompleted property
    };
  }
}
