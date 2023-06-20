import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/controllers/email_cooldown_controller.dart';
import '../../shared/widgets/submit_button.dart';
import '../controllers/email_verification_controller.dart';

class ResendButton extends ConsumerWidget {
  const ResendButton({super.key});

  String _getText(EmailCooldownState cooldownState) {
    if (cooldownState.isInCooldown) {
      return "Resend in ${cooldownState.time}";
    }
    return "No Email? Resend";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cooldownState = ref.watch(emailCooldownProvider);
    final cooldownController = ref.watch(emailVerificationProvider.notifier);

    return SubmitButton(
      text: _getText(cooldownState),
      onPressed: () => cooldownController.resendVerification(),
      disabled: cooldownState.isInCooldown,
    );
  }
}
