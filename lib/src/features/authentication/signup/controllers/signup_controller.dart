import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';

part './signup_state.dart';

final signupProvider =
    StateNotifierProvider.autoDispose<_SignupController, SignupState>(
        (ref) => _SignupController());

class _SignupController extends StateNotifier<SignupState> {
  _SignupController() : super(const SignupState());

  void onNameChange(String value) {
    state = state.copyWith(name: NameValidator.dirty(value));
  }

  void onEmailChange(String value) {
    state = state.copyWith(email: EmailValidator.dirty(value));
  }

  void onPasswordChange(String value) {
    state = state.copyWith(password: PasswordValidator.dirty(value));
  }

  void signupWithEmailAndPassword() async {
    if (!state.status.isValidated) return;
    print("Sign Up");
  }
}
