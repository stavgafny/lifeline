import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/submit_button.dart';
import '../../shared/widgets/loading_sheet.dart';
import '../controllers/signup_controller.dart';

class SignupButton extends ConsumerWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupState = ref.watch(signupProvider);
    final controller = ref.read(signupProvider.notifier);
    final validated = signupState.status.isValidated;

    return SubmitButton(
      text: "Sign Up",
      onPressed: validated
          ? () {
              LoadingSheet.show(context);
              controller.signupWithEmailAndPassword();
            }
          : null,
    );
  }
}
