part of './signup_controller.dart';

class SignupState {
  final NameValidator name;
  final EmailValidator email;
  final PasswordValidator password;
  final FormSubmissionStatus status;
  final String? errorMessage;

  const SignupState({
    this.name = const NameValidator.pure(),
    this.email = const EmailValidator.pure(),
    this.password = const PasswordValidator.pure(),
    this.status = FormSubmissionStatus.init,
    this.errorMessage,
  });

  bool get isValidated => FormValidator.validateAll([name, email, password]);

  SignupState copyWith({
    NameValidator? name,
    EmailValidator? email,
    PasswordValidator? password,
    FormSubmissionStatus? status,
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
