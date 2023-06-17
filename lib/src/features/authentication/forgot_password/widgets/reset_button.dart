import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/submit_button.dart';
import '../controllers/forgot_password_controller.dart';
import '../controllers/reset_cooldown_controller.dart';

class ResetButton extends ConsumerWidget {
  const ResetButton({super.key});

  String _getText(ForgotPasswordState state, ResetCooldownState cooldownState) {
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
    final resetCooldownState = ref.watch(resetCooldownProvider);
    final controller = ref.read(forgotPasswordProvider.notifier);

    return SubmitButton(
      text: _getText(forgotPasswordState, resetCooldownState),
      onPressed: controller.forgotPassword,
      disabled: resetCooldownState.isInCooldown,
    );
  }
}
