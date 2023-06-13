import 'dart:async';
import 'package:fire_auth/fire_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../repositories/auth_repo_provider.dart';
part './auth_state.dart';

final authProvider =
    StateNotifierProvider<_AuthenticationController, AuthState>(
  (ref) => _AuthenticationController(ref.watch(authRepoProvider)),
);

class _AuthenticationController extends StateNotifier<AuthState> {
  final AuthHandler _authHandler;
  StreamSubscription? _userStreamSubscription;

  _AuthenticationController(this._authHandler)
      : super(const AuthState.initialized()) {
    _userStreamSubscription =
        _authHandler.user.listen((user) => _onUserChanged(user));
  }

  void _onUserChanged(AuthUser user) {
    state = user.isEmpty
        ? const AuthState.unauthenticated()
        : AuthState.authenticated(user);
  }

  void onSignOut() => _authHandler.signOut();

  @override
  void dispose() {
    _userStreamSubscription?.cancel();
    super.dispose();
  }
}
