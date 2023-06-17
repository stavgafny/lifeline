import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import 'package:fire_auth/fire_auth.dart';
import '../../../../repositories/auth_repo_provider.dart';

part './forgot_password_state.dart';

final forgotPasswordTimeoutProvider = StateNotifierProvider<
    _ForgotPasswordTimeoutController,
    ForgotPasswordTimeoutState>((ref) => _ForgotPasswordTimeoutController());

final forgotPasswordProvider = StateNotifierProvider.autoDispose<
    _ForgotPasswordController, ForgotPasswordState>((ref) {
  return _ForgotPasswordController(
    ref.watch(authRepoProvider),
    ref.watch(forgotPasswordTimeoutProvider.notifier),
  );
});

class _ForgotPasswordController extends StateNotifier<ForgotPasswordState> {
  final AuthHandler _authHandler;
  final _ForgotPasswordTimeoutController _timeoutController;

  _ForgotPasswordController(this._authHandler, this._timeoutController)
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
      _timeoutController.setTimeout();
    } on ForgotPasswordException catch (e) {
      state = state.copyWith(
          status: FormSubmissionStatus.failure, errorMessage: e.code);
    } finally {
      state = state.copyWith(status: FormSubmissionStatus.init);
    }
  }
}

class _ForgotPasswordTimeoutController
    extends StateNotifier<ForgotPasswordTimeoutState> {
  static const timeoutDuration = Duration(seconds: 30);

  Timer? _timer;
  _ForgotPasswordTimeoutController() : super(ForgotPasswordTimeoutState());

  void _clearTimer() => _timer?.cancel();

  void _updateTime(int time) => state = state.copyWith(time);

  void _setTimeout() => _updateTime(timeoutDuration.inSeconds);

  void setTimeout() {
    _clearTimer();
    _setTimeout();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime(max(state.timeout - 1, 0));
      if (!state.isTimedOut) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class ForgotPasswordTimeoutState {
  final int timeout;
  ForgotPasswordTimeoutState([this.timeout = 0]);

  bool get isTimedOut => timeout > 0;

  ForgotPasswordTimeoutState copyWith([int? timeout]) {
    return ForgotPasswordTimeoutState(timeout ?? this.timeout);
  }
}
