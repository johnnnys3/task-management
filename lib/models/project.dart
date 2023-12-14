// models/project.dart
class Project {
  final String name;
  final List<String> tasks; // Task IDs associated with the project

  Project({
    required this.name,
    required this.tasks,
  });
}
