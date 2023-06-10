import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/text_input.dart';
import '../controllers/signup_controller.dart';

class PasswordField extends ConsumerWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupState = ref.watch(signupProvider);
    final hasError = signupState.password.invalid;
    final controller = ref.read(signupProvider.notifier);

    return TextInput.password(
      autofillHints: const [AutofillHints.newPassword],
      errorText: hasError
          ? PasswordValidator.getErrorMessage(signupState.password.error)
          : null,
      onChanged: (value) => controller.onPasswordChange(value),
    );
  }
}