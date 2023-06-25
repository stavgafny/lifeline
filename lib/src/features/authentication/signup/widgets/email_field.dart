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
    final error = signupState.email.error;
    final controller = ref.watch(signupProvider.notifier);

    return TextInput.email(
      errorText: EmailValidator.getErrorMessage(error),
      onChanged: error != null ? controller.onEmailChange : null,
      onBlur: controller.validateEmail,
    );
  }
}
