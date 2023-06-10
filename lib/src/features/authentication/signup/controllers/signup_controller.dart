import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';

part './signup_state.dart';

final signupProvider =
    StateNotifierProvider.autoDispose<_SignupController, SignupState>(
        (ref) => _SignupController());

class _SignupController extends StateNotifier<SignupState> {
  _SignupController() : super(const SignupState());

  void _update({
    NameValidator? name,
    EmailValidator? email,
    PasswordValidator? password,
  }) {
    state = state.copyWith(name: name, email: email, password: password);
  }

  void onNameChange(String value) {
    _update(name: NameValidator(value));
  }

  void onEmailChange(String value) {
    _update(email: EmailValidator(value));
  }

  void onPasswordChange(String value) {
    _update(password: PasswordValidator(value));
  }

  void validateName() {
    _update(name: NameValidator(state.name.value, true));
  }

  void validateEmail() {
    _update(email: EmailValidator(state.email.value, true));
  }

  void validatePassword() {
    _update(password: PasswordValidator(state.password.value, true));
  }

  void signupWithEmailAndPassword() async {
    if (!state.isValidated) return;
    print("Sign Up");
  }
}
