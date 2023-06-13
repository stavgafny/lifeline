import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/submit_button.dart';
import '../controllers/forgot_password_controller.dart';

class ResetButton extends ConsumerWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final controller = ref.read(forgotPasswordProvider.notifier);
    final status = forgotPasswordState.status;

    final flag = status == FormSubmissionStatus.progress ||
        status == FormSubmissionStatus.success;

    return SubmitButton(
      text: flag ? "sent" : "Reset Password",
      onPressed: controller.forgotPassword,
    );
  }
}
