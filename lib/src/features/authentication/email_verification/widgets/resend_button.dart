import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/controllers/email_cooldown_controller.dart';
import '../../shared/widgets/submit_button.dart';
import '../controllers/email_verification_controller.dart';

class ResendButton extends ConsumerWidget {
  const ResendButton({super.key});

  String _getText(
      EmailVerificationState state, EmailCooldownState cooldownState) {
    if (state.status == EmailVerificationStatus.progress) {
      return "Sending";
    }
    if (cooldownState.isInCooldown) {
      if (state.status == EmailVerificationStatus.error) {
        return "Too many emails aahh";
      }
      return "Resend in ${cooldownState.time}";
    }
    return "No Email? Resend";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailVerificationState = ref.watch(emailVerificationProvider);
    final emailCooldownState = ref.watch(emailCooldownProvider);
    final controller = ref.watch(emailVerificationProvider.notifier);
    final inProgress = emailVerificationState.inProgress;

    return SubmitButton(
      text: _getText(emailVerificationState, emailCooldownState),
      onPressed: inProgress ? null : controller.resendVerification,
      disabled: emailCooldownState.isInCooldown,
    );
  }
}
