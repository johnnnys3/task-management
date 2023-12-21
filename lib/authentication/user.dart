class CustomUser {
  final String uid;
  final String email;
  final String name; // Add this line
  final String role;
  final List<String> assignedProjects;

  CustomUser({
    required this.uid,
    required this.email,
    required this.name, // Add this line
    required this.role,
    required this.assignedProjects,
  });

  CustomUser copyWith({
    String? uid,
    String? name,
    String? email,
    String? role,
    List<String>? assignedProjects,
  }) {
    return CustomUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      assignedProjects: assignedProjects ?? this.assignedProjects,
    );
  }
}
