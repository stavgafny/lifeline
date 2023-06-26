class AuthUser {
  static const empty = AuthUser(id: '');

  final String id;
  final String? email;
  final String? name;
  final bool emailVerified;
  final String? photoURL;

  const AuthUser({
    required this.id,
    this.email,
    this.name,
    this.emailVerified = false,
    this.photoURL,
  });

  bool get isEmpty => id.isEmpty;
}
