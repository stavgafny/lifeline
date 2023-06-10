part of './signin_controller.dart';

class SigninState {
  final EmailValidator email;
  final PasswordValidator password;
  final FormzStatus status;
  final String? errorMessage;

  const SigninState({
    this.email = const EmailValidator.pure(),
    this.password = const PasswordValidator.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  SigninState copyWith({
    EmailValidator? email,
    PasswordValidator? password,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return SigninState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
