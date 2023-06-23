import 'dart:async';

import 'package:fire_auth/fire_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../repositories/auth_repo_provider.dart';
import '../../shared/controllers/email_cooldown_controller.dart';

part './email_verification_state.dart';

final emailVerificationProvider = StateNotifierProvider.autoDispose<
    _EmailVerificationController, EmailVerificationState>((ref) {
  return _EmailVerificationController(
    ref.watch(authRepoProvider),
    ref.watch(emailCooldownProvider.notifier),
  );
});

class _EmailVerificationController
    extends StateNotifier<EmailVerificationState> {
  static const reloadUserInterval = Duration(seconds: 3);

  final AuthHandler _authHandler;
  final EmailCooldownController _emailCooldownController;
  Timer? _timer;

  _EmailVerificationController(this._authHandler, this._emailCooldownController)
      : super(const EmailVerificationState()) {
    _setUserReloadInterval();
  }

  void _setUserReloadInterval() {
    _timer?.cancel();
    _timer = Timer.periodic(reloadUserInterval, (timer) async {
      await _authHandler.reload();
    });
  }

  void resendVerification() async {
    state = state.copyWith(status: EmailVerificationStatus.progress);
    try {
      await _authHandler.sendEmailVerification();
      state = state.copyWith(status: EmailVerificationStatus.init);
    } on SendEmailVerificationException {
      state = state.copyWith(status: EmailVerificationStatus.error);
    } finally {
      _emailCooldownController.setCooldown();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
