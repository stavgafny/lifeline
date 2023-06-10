import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/text_input.dart';
import '../controllers/signin_controller.dart';

class EmailField extends ConsumerWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signinState = ref.watch(signinProvider);
    final controller = ref.read(signinProvider.notifier);
    final error = signinState.email.error;

    return TextInput.email(
      errorText: EmailValidator.getErrorMessage(error),
      onChanged: error != null ? controller.onEmailChange : null,
      onBlur: (value) => controller.validateEmail(value),
    );
  }
}
