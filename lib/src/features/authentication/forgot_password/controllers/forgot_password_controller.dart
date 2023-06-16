import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import 'package:fire_auth/fire_auth.dart';
import '../../../../repositories/auth_repo_provider.dart';

part './forgot_password_state.dart';

final forgotPasswordProvider = StateNotifierProvider.autoDispose<
        _ForgotPasswordController, ForgotPasswordState>(
    (ref) => _ForgotPasswordController(ref.watch(authRepoProvider)));

class _ForgotPasswordController extends StateNotifier<ForgotPasswordState> {
  static const timeoutDuration = Duration(seconds: 30);

  final AuthHandler _authHandler;
  Timer? _timer;

  _ForgotPasswordController(this._authHandler)
      : super(const ForgotPasswordState());

  void _setTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final timeout = max(state.timeout - 1, 0);
      state = state.copyWith(timeout: timeout);
      if (!state.isTimedOut) {
        timer.cancel();
      }
    });
  }

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
        timeout: timeoutDuration.inSeconds,
      );
      _setTimer();
    } on ForgotPasswordException catch (e) {
      state = state.copyWith(
          status: FormSubmissionStatus.failure, errorMessage: e.code);
    } finally {
      state = state.copyWith(status: FormSubmissionStatus.init);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
