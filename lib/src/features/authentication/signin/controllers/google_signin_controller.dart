import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fire_auth/fire_auth.dart';
import '../../../../repositories/auth_repo_provider.dart';

final googleSigninProvider = StateNotifierProvider.autoDispose<
        _GoogleSigninController, GoogleSigninState>(
    (ref) => _GoogleSigninController(ref.watch(authRepoProvider)));

enum GoogleSigninState { init, loading, error, success }

class _GoogleSigninController extends StateNotifier<GoogleSigninState> {
  final AuthHandler _authHandler;

  _GoogleSigninController(this._authHandler) : super(GoogleSigninState.init);

  Future<void> signinWithGoogle() async {
    state = GoogleSigninState.loading;
    try {
      final isNewUser = await _authHandler.signInWithGoogle();

      if (isNewUser != null && isNewUser) {
        //! NEW USER
      }

      state = GoogleSigninState.success;
    } on SignInWithGoogleException catch (_) {
      state = GoogleSigninState.error;
    } finally {
      state = GoogleSigninState.init;
    }
  }
}
