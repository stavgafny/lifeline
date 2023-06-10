part of './signup_controller.dart';

class SignupState {
  final NameValidator name;
  final EmailValidator email;
  final PasswordValidator password;

  const SignupState({
    this.name = const NameValidator.pure(),
    this.email = const EmailValidator.pure(),
    this.password = const PasswordValidator.pure(),
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
