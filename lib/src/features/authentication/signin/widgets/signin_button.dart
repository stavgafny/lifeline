import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/widgets/submit_button.dart';
import '../controllers/signin_controller.dart';

class SigninButton extends ConsumerWidget {
  const SigninButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSubmittable = ref.watch(
      signinProvider.select((signinState) => signinState.isSubmittable),
    );
    final isInProgress = ref.watch(
      signinProvider.select((signinState) => signinState.isInProgress),
    );

    return SubmitButton(
      text: "Sign In",
      onPressed: isSubmittable
          ? ref.read(signinProvider.notifier).signinWithEmailAndPassword
          : null,
      disabled: isInProgress,
    );
  }
}
