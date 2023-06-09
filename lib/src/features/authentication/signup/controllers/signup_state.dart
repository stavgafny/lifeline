part of './signup_controller.dart';

class SignupState {
  final NameValidator name;
  final EmailValidator email;
  final PasswordValidator password;
  final FormzStatus status;
  final String? errorMessage;

  const SignupState({
    this.name = const NameValidator.pure(),
    this.email = const EmailValidator.pure(),
    this.password = const PasswordValidator.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  SignupState copyWith({
    NameValidator? name,
    EmailValidator? email,
    PasswordValidator? password,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return SignupState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
