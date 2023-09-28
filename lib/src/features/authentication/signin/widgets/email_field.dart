import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/text_input.dart';
import '../controllers/signin_controller.dart';

class EmailField extends ConsumerWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signinStateError = ref
        .watch(signinProvider.select((signinState) => signinState.email.error));

    return TextInput.email(
      errorText: EmailValidator.getErrorMessage(signinStateError),
      onChanged: ref.read(signinProvider.notifier).onEmailChange,
      onBlur: ref.read(signinProvider.notifier).validateEmail,
    );
  }
}
