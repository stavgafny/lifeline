import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/submit_button.dart';
import '../controllers/forgot_password_controller.dart';

class ResetButton extends ConsumerWidget {
  const ResetButton({super.key});

  String _getText(ForgotPasswordState state, ForgotPasswordTimeoutState time) {
    if (state.status == FormSubmissionStatus.progress) {
      return "Sending";
    }
    if (time.isTimedOut) {
      return "Resend in ${time.timeout}";
    }
    return "Reset Password";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final controller = ref.read(forgotPasswordProvider.notifier);
    final timeout = ref.watch(forgotPasswordTimeoutProvider);

    return SubmitButton(
      text: _getText(forgotPasswordState, timeout),
      onPressed: controller.forgotPassword,
      disabled: timeout.isTimedOut,
    );
  }
}
