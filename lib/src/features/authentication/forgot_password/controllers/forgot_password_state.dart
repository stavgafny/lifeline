part of './forgot_password_controller.dart';

class ForgotPasswordState {
  final EmailValidator email;
  final FormSubmissionStatus status;
  final String? errorMessage;

  const ForgotPasswordState({
    this.email = const EmailValidator.pure(),
    this.status = FormSubmissionStatus.init,
    this.errorMessage,
  });

  bool get isValidated => FormValidator.validateAll([email]);

  bool get isInProgress => status == FormSubmissionStatus.progress;

  bool get isSubmittable => isValidated && !isInProgress;

  ForgotPasswordState copyWith({
    EmailValidator? email,
    FormSubmissionStatus? status,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
