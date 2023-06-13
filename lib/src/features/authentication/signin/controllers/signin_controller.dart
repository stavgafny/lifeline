import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import 'package:fire_auth/fire_auth.dart';
import '../../../../repositories/auth_repo_provider.dart';

part './signin_state.dart';

final signinProvider =
    StateNotifierProvider.autoDispose<_SigninController, SigninState>(
        (ref) => _SigninController(ref.watch(authRepoProvider)));

class _SigninController extends StateNotifier<SigninState> {
  final AuthHandler _authHandler;
  _SigninController(this._authHandler) : super(const SigninState());

  void _update({
    EmailValidator? email,
    PasswordValidator? password,
    FormSubmissionStatus? status,
    String? errorMessage,
  }) {
    state = state.copyWith(
      email: email,
      password: password,
      status: status,
      errorMessage: errorMessage,
    );
  }

  void clear() => state = const SigninState();

  void onEmailChange(String value) {
    _update(email: EmailValidator.pure(value));
  }

  void onPasswordChange(String value) {
    _update(password: PasswordValidator.pure(value));
  }

  void validateEmail(String value) {
    _update(email: EmailValidator.dirty(value));
  }

  void validatePassword(String value) {
    _update(password: PasswordValidator.dirty(value));
  }

  void signinWithEmailAndPassword() async {
    if (!state.isValidated) return;

    _update(status: FormSubmissionStatus.progress);

    try {
      await _authHandler.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      _update(status: FormSubmissionStatus.success);
    } on SignInWithEmailAndPasswordException catch (e) {
      _update(status: FormSubmissionStatus.failure, errorMessage: e.code);
    } finally {
      _update(status: FormSubmissionStatus.init, errorMessage: null);
    }
  }
}
