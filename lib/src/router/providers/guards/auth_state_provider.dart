import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StreamProvider<AuthState>((ref) {
  return FirebaseAuth.instance
      .authStateChanges()
      .map((user) => AuthState(user));
});

class AuthState {
  final User? _user;

  const AuthState(this._user);

  /// Whether the user exists - signed in (not necessarily verified)
  bool get exist => _user != null && _user?.uid != null;

  /// Can only be true if the user exists
  bool get verified => exist && _user!.emailVerified;
}
