// models/team.dart
class Team {
  final String name;
  final List<String> members; // User IDs of team members
  final List<String> projects; // Project IDs associated with the team

  Team({
    required this.name,
    required this.members,
    required this.projects,
  });
}
