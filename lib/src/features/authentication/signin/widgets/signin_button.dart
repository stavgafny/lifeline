import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/submit_button.dart';
import '../controllers/signin_controller.dart';

class SigninButton extends ConsumerWidget {
  const SigninButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signinState = ref.watch(signinProvider);
    final controller = ref.read(signinProvider.notifier);
    final isValidated = signinState.isValidated;
    final isInProgress = signinState.status == FormSubmissionStatus.progress;

    return SubmitButton(
      text: "Sign In",
      onPressed: isValidated ? controller.signinWithEmailAndPassword : null,
      disabled: isInProgress,
    );
  }
}
