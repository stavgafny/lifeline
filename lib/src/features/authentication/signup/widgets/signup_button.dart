import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/widgets/submit_button.dart';
import '../controllers/signup_controller.dart';

class SignupButton extends ConsumerWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSubmittable = ref.watch(
      signupProvider.select((signupState) => signupState.isSubmittable),
    );

    return SubmitButton(
      text: "Sign Up",
      onPressed: isSubmittable
          ? ref.read(signupProvider.notifier).signupWithEmailAndPassword
          : null,
    );
  }
}
