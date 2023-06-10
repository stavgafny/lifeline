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
    print("Sign Up");
  }
}
