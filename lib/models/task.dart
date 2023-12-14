// models/task.dart
class Task {
  final String title;
  final String description;
  final DateTime dueDate;
  final int priority;
  final List<String> attachments;
  final String assignedTo;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.attachments,
    required this.assignedTo,
  });
}
