// models/task.dart
class Task {
  final int id; // Include the id property
  final String title;
  final String description;
  final DateTime dueDate;

  final List<String> attachments;
  final String assignedTo;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    
    required this.attachments,
    required this.assignedTo,
    this.isCompleted = false,
  });

  // Add the fromMap factory method to convert from Map to Task
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
     
      attachments: List<String>.from(map['attachments']),
      assignedTo: map['assignedTo'],
      isCompleted: map['isCompleted'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Include the id property
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
     
      'attachments': attachments,
      'assignedTo': assignedTo,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }
}
