import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/widgets/submit_button.dart';
import '../controllers/signup_controller.dart';

class SignupButton extends ConsumerWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupState = ref.watch(signupProvider);
    final isValidated = signupState.isValidated;
    final controller = ref.watch(signupProvider.notifier);

    return SubmitButton(
      text: "Sign Up",
      onPressed: isValidated ? controller.signupWithEmailAndPassword : null,
    );
  }
}
