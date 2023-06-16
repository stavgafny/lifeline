part of './forgot_password_controller.dart';

class ForgotPasswordState {
  final EmailValidator email;
  final FormSubmissionStatus status;
  final String? errorMessage;
  final int timeout;

  const ForgotPasswordState({
    this.email = const EmailValidator.pure(),
    this.status = FormSubmissionStatus.init,
    this.errorMessage,
    this.timeout = 0,
  });

  bool get isValidated => FormValidator.validateAll([email]);

  bool get isTimedOut => timeout > 0;

  ForgotPasswordState copyWith({
    EmailValidator? email,
    FormSubmissionStatus? status,
    String? errorMessage,
    int? timeout,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      timeout: timeout ?? this.timeout,
    );
  }
}
