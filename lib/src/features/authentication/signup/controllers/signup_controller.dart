import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import 'package:fire_auth/fire_auth.dart';
import '../../../../repositories/auth_repo_provider.dart';

part './signup_state.dart';

final signupProvider =
    StateNotifierProvider.autoDispose<_SignupController, SignupState>(
        (ref) => _SignupController(ref.watch(authRepoProvider)));

class _SignupController extends StateNotifier<SignupState> {
  final AuthHandler _authenticationHandler;
  _SignupController(this._authenticationHandler) : super(const SignupState());

  void _update({
    NameValidator? name,
    EmailValidator? email,
    PasswordValidator? password,
  }) {
    state = state.copyWith(name: name, email: email, password: password);
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
    // set loading
    try {
      await _authenticationHandler.signUpWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      // state status to success
    } on SignUpWithEmailAndPasswordException catch (e) {
      e;
      // set failure
    }
  }
}
