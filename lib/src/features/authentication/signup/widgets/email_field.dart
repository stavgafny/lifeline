import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/text_input.dart';
import '../controllers/signup_controller.dart';

class EmailField extends ConsumerWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupStateError = ref
        .watch(signupProvider.select((signupState) => signupState.email.error));

    return TextInput.email(
      errorText: EmailValidator.getErrorMessage(signupStateError),
      onChanged: ref.read(signupProvider.notifier).onEmailChange,
      onBlur: ref.read(signupProvider.notifier).validateEmail,
    );
  }
}
