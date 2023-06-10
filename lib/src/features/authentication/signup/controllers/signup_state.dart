part of './signup_controller.dart';

class SignupState {
  final NameValidator name;
  final EmailValidator email;
  final PasswordValidator password;

  const SignupState({
    this.name = const NameValidator(),
    this.email = const EmailValidator(),
    this.password = const PasswordValidator(),
  });

  bool get isValidated => FormValidator.validateAll([name, email, password]);

  SignupState copyWith({
    NameValidator? name,
    EmailValidator? email,
    PasswordValidator? password,
  }) {
    return SignupState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
