class AuthUser {
  static const empty = AuthUser(id: '');

  final String id;
  final String? email;
  final String? name;
  final bool emailVerified;

  const AuthUser({
    required this.id,
    this.email,
    this.name,
    this.emailVerified = false,
  });

  bool get isEmpty => id.isEmpty;
}
