part of './signin_controller.dart';

class SigninState {
  final EmailValidator email;
  final PasswordValidator password;

  const SigninState({
    this.email = const EmailValidator.pure(),
    this.password = const PasswordValidator.pure(),
  });

  bool get isValidated => FormValidator.validateAll([email, password]);

  SigninState copyWith({EmailValidator? email, PasswordValidator? password}) {
    return SigninState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
