import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import 'package:fire_auth/fire_auth.dart';
import '../../../../repositories/auth_repo_provider.dart';
import '../../shared/utils/auth_error_handler.dart';

part './signup_state.dart';

final signupProvider =
    StateNotifierProvider.autoDispose<_SignupController, SignupState>(
        (ref) => _SignupController(ref.watch(authRepoProvider)));

class _SignupController extends StateNotifier<SignupState> {
  final AuthHandler _authHandler;
  _SignupController(this._authHandler) : super(const SignupState());

  void _update({
    NameValidator? name,
    EmailValidator? email,
    PasswordValidator? password,
    FormSubmissionStatus? status,
    String? errorMessage,
  }) {
    state = state.copyWith(
      name: name,
      email: email,
      password: password,
      status: status,
      errorMessage: errorMessage,
    );
  }

  void onNameChange(String value) {
    _update(name: NameValidator.pure(value));
  }

  void onEmailChange(String value) {
    _update(email: EmailValidator.pure(value));
  }

  void onPasswordChange(String value) {
    _update(password: PasswordValidator.pure(value));
  }

  void validateName(String value) {
    _update(name: NameValidator.dirty(value));
  }

  void validateEmail(String value) {
    _update(email: EmailValidator.dirty(value));
  }

  void validatePassword(String value) {
    _update(password: PasswordValidator.dirty(value));
  }

  void signupWithEmailAndPassword() async {
    if (!state.isValidated) return;
    _update(status: FormSubmissionStatus.progress);
    try {
      await _authHandler.signUpWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
        options: SignUpWithEmailAndPasswordOptions(
          name: state.name.value,
          sendEmailVerification: true,
        ),
      );
      _update(status: FormSubmissionStatus.success);
    } on SignUpWithEmailAndPasswordException catch (e) {
      final errorMessage = AuthErrorHandler.getErrorFromCode(e.code).message;
      _update(status: FormSubmissionStatus.failure, errorMessage: errorMessage);
    } finally {
      _update(status: FormSubmissionStatus.init);
    }
  }
}
