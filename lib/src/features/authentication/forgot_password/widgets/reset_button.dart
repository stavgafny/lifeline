import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/submit_button.dart';
import '../controllers/forgot_password_controller.dart';

class ResetButton extends ConsumerWidget {
  const ResetButton({super.key});

  String _getText(ForgotPasswordState state) {
    if (state.status == FormSubmissionStatus.progress) {
      return "Sending";
    }
    if (state.isTimedOut) {
      return "Resend in ${state.timeout}";
    }
    return "Reset Password";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final controller = ref.read(forgotPasswordProvider.notifier);

    return SubmitButton(
      text: _getText(forgotPasswordState),
      onPressed: controller.forgotPassword,
      disabled: forgotPasswordState.isTimedOut,
    );
  }
}
