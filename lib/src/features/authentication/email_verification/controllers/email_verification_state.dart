part of './email_verification_controller.dart';

enum EmailVerificationStatus { init, progress, error }

class EmailVerificationState {
  final EmailVerificationStatus status;

  const EmailVerificationState({this.status = EmailVerificationStatus.init});

  bool get inProgress => status == EmailVerificationStatus.progress;

  EmailVerificationState copyWith({EmailVerificationStatus? status}) {
    return EmailVerificationState(status: status ?? this.status);
  }
}
