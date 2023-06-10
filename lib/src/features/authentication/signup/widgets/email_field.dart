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
    final hasError = signupState.email.invalid;
    final controller = ref.read(signupProvider.notifier);

    return TextInput.email(
      errorText: hasError
          ? EmailValidator.getErrorMessage(signupState.email.error)
          : null,
      onChanged: (value) => controller.onEmailChange(value),
    );
  }
}