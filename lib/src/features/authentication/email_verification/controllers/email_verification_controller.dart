import 'package:fire_auth/fire_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../repositories/auth_repo_provider.dart';
import '../../shared/controllers/email_cooldown_controller.dart';

final emailVerificationProvider = StateNotifierProvider.autoDispose<
    _EmailVerificationController, EmailCooldownState>((ref) {
  return _EmailVerificationController(
    ref.watch(authRepoProvider),
    ref.watch(emailCooldownProvider.notifier),
  );
});

class _EmailVerificationController extends StateNotifier<EmailCooldownState> {
  final AuthHandler _authHandler;
  final EmailCooldownController _emailCooldownController;
  _EmailVerificationController(this._authHandler, this._emailCooldownController)
      : super(EmailCooldownState());

  void resendVerification() async {
    try {
      await _authHandler.sendEmailVerification();
      _emailCooldownController.setCooldown();
    } finally {}
  }
}
