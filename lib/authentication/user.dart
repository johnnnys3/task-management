class CustomUser {
  final String uid;
  final String email;
  final String role;

  CustomUser({
    required this.uid,
    required this.email,
    required this.role,
  });

  CustomUser copyWith({
    String? uid,
    String? email,
    String? role,
  }) {
    return CustomUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }
}
