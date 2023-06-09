import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';

part './signup_state.dart';

final signupProvider =
    StateNotifierProvider.autoDispose<_SignupController, SignupState>(
        (ref) => _SignupController());

class _SignupController extends StateNotifier<SignupState> {
  _SignupController() : super(const SignupState());

  void _update(
      {NameValidator? name,
      EmailValidator? email,
      PasswordValidator? password}) {
    state = state.copyWith(
      name: name,
      email: email,
      password: password,
      status: Formz.validate([
        name ?? state.name,
        email ?? state.email,
        password ?? state.password,
      ]),
    );
  }

  void onNameChange(String value) {
    _update(name: NameValidator.dirty(value));
  }

  void onEmailChange(String value) {
    _update(email: EmailValidator.dirty(value));
  }

  void onPasswordChange(String value) {
    _update(password: PasswordValidator.dirty(value));
  }

  void signupWithEmailAndPassword() async {
    if (!state.status.isValidated) return;
    print("Sign Up");
  }
}
