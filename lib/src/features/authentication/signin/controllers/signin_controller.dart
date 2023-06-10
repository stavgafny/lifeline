import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';

part './signin_state.dart';

final signinProvider =
    StateNotifierProvider.autoDispose<_SigninController, SigninState>(
        (ref) => _SigninController());

class _SigninController extends StateNotifier<SigninState> {
  _SigninController() : super(const SigninState());

  void _update({EmailValidator? email, PasswordValidator? password}) {
    state = state.copyWith(email: email, password: password);
  }

  void onEmailChange(String value) {
    _update(email: EmailValidator(value));
  }

  void onPasswordChange(String value) {
    _update(password: PasswordValidator(value));
  }

  void validateEmail() {
    _update(email: EmailValidator(state.email.value, true));
  }

  void validatePassword() {
    _update(password: PasswordValidator(state.password.value, true));
  }

  void signinWithEmailAndPassword() async {
    if (!state.isValidated) return;
    print("Sign In");
  }
}
