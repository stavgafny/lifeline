import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/controllers/email_cooldown_controller.dart';
import '../../shared/widgets/submit_button.dart';
import '../controllers/forgot_password_controller.dart';

class ResetButton extends ConsumerWidget {
  const ResetButton({super.key});

  String _getText(ForgotPasswordState state, EmailCooldownState cooldownState) {
    if (state.status == FormSubmissionStatus.progress) {
      return "Sending";
    }
    if (cooldownState.isInCooldown) {
      return "Resend in ${cooldownState.time}";
    }
    return "Reset Password";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final emailCooldownState = ref.watch(emailCooldownProvider);
    final controller = ref.watch(forgotPasswordProvider.notifier);

    return SubmitButton(
      text: _getText(forgotPasswordState, emailCooldownState),
      onPressed: controller.forgotPassword,
      disabled: emailCooldownState.isInCooldown,
    );
  }
}
