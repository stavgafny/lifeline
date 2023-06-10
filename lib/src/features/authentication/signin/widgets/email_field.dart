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

    return TextInput.email(
      errorText: EmailValidator.getErrorMessage(signinState.email.error),
      onChanged: (value) => controller.onEmailChange(value),
      onBlur: () => controller.validateEmail(),
    );
  }
}
