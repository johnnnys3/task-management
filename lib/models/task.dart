import 'package:cloud_firestore/cloud_firestore.dart';
import 'project.dart'; // Import the Project model

class Task {
  final int id;
  final String title;
  final String description;
  final DateTime dueDate;

  final List<String> attachments;
  final String assignedTo;
  bool isCompleted;

  final Project? associatedProject; // Reference to the associated project

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    
    required this.attachments,
    required this.assignedTo,
    required this.isCompleted,
    required this.associatedProject, // Include the associated project
  });

  // Add the fromDocumentSnapshot factory method to convert from DocumentSnapshot to Task
  factory Task.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Task(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      dueDate: DateTime.parse(data['dueDate']),
     
      attachments: List<String>.from(data['attachments']),
      assignedTo: data['assignedTo'],
      isCompleted: data['isCompleted'] == 1,
      associatedProject: Project.fromMap(data['associatedProject']), // Convert the associated project map to a Project object
    );
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      attachments: List<String>.from(map['attachments']),
      assignedTo: map['assignedTo'],
      isCompleted: map['isCompleted'] == 1,
      associatedProject: Project.fromMap(map['associatedProject']), // Convert the associated project map to a Project object
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
     
      'attachments': attachments,
      'assignedTo': assignedTo,
      'isCompleted': isCompleted ? 1 : 0,
      'associatedProject': associatedProject!.toMap(), // Convert the associated project to a map
    };
  }


  bool get hasDueDate => dueDate != null;
}
