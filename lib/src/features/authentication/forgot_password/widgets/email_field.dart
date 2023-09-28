import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/text_input.dart';
import '../controllers/forgot_password_controller.dart';

class EmailField extends ConsumerWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgotPasswordStateError = ref.watch(forgotPasswordProvider
        .select((forgotPasswordState) => forgotPasswordState.email.error));

    return TextInput.email(
      errorText: EmailValidator.getErrorMessage(forgotPasswordStateError),
      onChanged: ref.read(forgotPasswordProvider.notifier).onEmailChange,
      onBlur: ref.read(forgotPasswordProvider.notifier).validateEmail,
    );
  }
}
