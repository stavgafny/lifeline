import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/text_input.dart';
import '../controllers/signup_controller.dart';

class EmailField extends ConsumerWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupState = ref.watch(signupProvider);
    final controller = ref.watch(signupProvider.notifier);
    final error = signupState.email.error;

    return TextInput.email(
      errorText: EmailValidator.getErrorMessage(error),
      onChanged: controller.onEmailChange,
      onBlur: controller.validateEmail,
    );
  }
}
