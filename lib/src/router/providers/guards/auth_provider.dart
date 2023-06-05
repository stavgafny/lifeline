import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StreamProvider<_UserAuthState>((ref) {
  return FirebaseAuth.instance
      .authStateChanges()
      .map((user) => _UserAuthState(user));
});

class _UserAuthState {
  final User? _user;

  const _UserAuthState(this._user);

  /// Whether the user exists - signed in (not necessarily verified)
  bool get exist => _user != null && _user?.uid != null;

  /// Can only be true if the user exists
  bool get verified => exist && _user!.emailVerified;
}
