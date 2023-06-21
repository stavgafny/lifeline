import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import 'package:fire_auth/fire_auth.dart';
import '../../../../repositories/auth_repo_provider.dart';
import '../../shared/controllers/email_cooldown_controller.dart';
import '../../shared/utils/error_message_handler.dart';

part './forgot_password_state.dart';

final forgotPasswordProvider = StateNotifierProvider.autoDispose<
    _ForgotPasswordController, ForgotPasswordState>((ref) {
  return _ForgotPasswordController(
    ref.watch(authRepoProvider),
    ref.watch(emailCooldownProvider.notifier),
  );
});

class _ForgotPasswordController extends StateNotifier<ForgotPasswordState> {
  final AuthHandler _authHandler;
  final EmailCooldownController _emailCooldownController;

  _ForgotPasswordController(this._authHandler, this._emailCooldownController)
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
      state = state.copyWith(status: FormSubmissionStatus.success);
      _emailCooldownController.setCooldown();
    } on ForgotPasswordException catch (e) {
      final errorMessage = ErrorMessageHandler.generateErrorMessage(
          ErrorMessageHandler.getErrorCode(e.code));
      state = state.copyWith(
          status: FormSubmissionStatus.failure, errorMessage: errorMessage);
    } finally {
      state = state.copyWith(status: FormSubmissionStatus.init);
    }
  }
}
