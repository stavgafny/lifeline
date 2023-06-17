import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import 'package:fire_auth/fire_auth.dart';
import '../../../../repositories/auth_repo_provider.dart';
import './reset_cooldown_controller.dart';

part './forgot_password_state.dart';

final forgotPasswordProvider = StateNotifierProvider.autoDispose<
    _ForgotPasswordController, ForgotPasswordState>((ref) {
  return _ForgotPasswordController(
    ref.watch(authRepoProvider),
    ref.watch(resetCooldownProvider.notifier),
  );
});

class _ForgotPasswordController extends StateNotifier<ForgotPasswordState> {
  final AuthHandler _authHandler;
  final ResetCooldownController _resetCooldownController;

  _ForgotPasswordController(this._authHandler, this._resetCooldownController)
      : super(const ForgotPasswordState());

  void onEmailChange(String value) {
    state = state.copyWith(email: EmailValidator.pure(value));
  }

  void validateEmail(String value) {
    state = state.copyWith(email: EmailValidator.dirty(value));
  }

  void forgotPassword() async {
    if (!state.isValidated) return;
    state = state.copyWith(status: FormSubmissionStatus.progress);
    try {
      await _authHandler.forgotPassword(email: state.email.value);
      state = state.copyWith(
        status: FormSubmissionStatus.success,
      );
      _resetCooldownController.setCooldown();
    } on ForgotPasswordException catch (e) {
      state = state.copyWith(
          status: FormSubmissionStatus.failure, errorMessage: e.code);
    } finally {
      state = state.copyWith(status: FormSubmissionStatus.init);
    }
  }
}
