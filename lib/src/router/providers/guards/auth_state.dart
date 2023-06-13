part of './auth_state_provider.dart';

enum AuthStatus { initialized, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final AuthUser user;

  const AuthState._({
    required this.status,
    this.user = AuthUser.empty,
  });

  const AuthState.initialized() : this._(status: AuthStatus.initialized);

  const AuthState.authenticated(AuthUser user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);
}
