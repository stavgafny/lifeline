part of './signin_controller.dart';

class SigninState {
  final EmailValidator email;
  final PasswordValidator password;
  final FormSubmissionStatus status;
  final String? errorMessage;

  const SigninState({
    this.email = const EmailValidator.pure(),
    this.password = const PasswordValidator.pure(),
    this.status = FormSubmissionStatus.init,
    this.errorMessage,
  });

  bool get isValidated => FormValidator.validateAll([email, password]);

  bool get inProgress => status == FormSubmissionStatus.progress;

  SigninState copyWith({
    EmailValidator? email,
    PasswordValidator? password,
    FormSubmissionStatus? status,
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
