import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/text_input.dart';
import '../controllers/forgot_password_controller.dart';

class EmailField extends ConsumerWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final controller = ref.watch(forgotPasswordProvider.notifier);
    final error = forgotPasswordState.email.error;

    return TextInput.email(
      errorText: EmailValidator.getErrorMessage(error),
      onChanged: controller.onEmailChange,
      onBlur: controller.validateEmail,
    );
  }
}
