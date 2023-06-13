part of './signin_controller.dart';

class SigninState {
  final EmailValidator email;
  final PasswordValidator password;
  final FormSubmissionStatus status;

  const SigninState({
    this.email = const EmailValidator.pure(),
    this.password = const PasswordValidator.pure(),
    this.status = FormSubmissionStatus.init,
  });

  bool get isValidated => FormValidator.validateAll([email, password]);

  SigninState copyWith({
    EmailValidator? email,
    PasswordValidator? password,
    FormSubmissionStatus? status,
  }) {
    return SigninState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
