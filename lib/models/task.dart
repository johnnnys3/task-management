import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management/models/project.dart';

class Task {
  final String id; // Change the type to String
  final String title;
  final String description;
  final DateTime dueDate;

  final List<String> attachments;
  final String assignedTo;
  bool isCompleted;

  final Project? associatedProject;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.attachments,
    required this.assignedTo,
    required this.isCompleted,
    required this.associatedProject,
  });

  factory Task.fromDocumentSnapshot(QueryDocumentSnapshot<Object?> snapshot) {
  Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  return Task(
    id: snapshot.id,
    title: data['title'],
    description: data['description'],
    dueDate: DateTime.parse(data['dueDate']),
    attachments: List<String>.from(data['attachments']),
    assignedTo: data['assignedTo'],
    isCompleted: data['isCompleted'] == 1,
    associatedProject: data['associatedProject'] != null
        ? Project.fromMap(data['associatedProject'], data['associatedProject']['id'])
        : null,
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
      associatedProject: map['associatedProject'] != null
          ? Project.fromMap(map['associatedProject'], map['associatedProject']['id'])
          : null,
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
      'associatedProject': associatedProject!.toMap(),
    };
  }

  bool get hasDueDate => dueDate != null;
}
