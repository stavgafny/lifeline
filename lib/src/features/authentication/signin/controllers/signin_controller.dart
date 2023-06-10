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

  void validateEmail(String value) {
    _update(email: EmailValidator.dirty(value));
  }

  void validatePassword(String value) {
    _update(password: PasswordValidator.dirty(value));
  }

  void signinWithEmailAndPassword() async {
    if (!state.isValidated) return;
    print("Sign In");
  }
}
