import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/text_input.dart';
import '../controllers/signup_controller.dart';

class PasswordField extends ConsumerWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupStateError = ref.watch(
        signupProvider.select((signupState) => signupState.password.error));

    return TextInput.password(
      autofillHints: const [AutofillHints.newPassword],
      errorText: PasswordValidator.getErrorMessage(signupStateError),
      onChanged: ref.read(signupProvider.notifier).onPasswordChange,
      onBlur: ref.read(signupProvider.notifier).validatePassword,
    );
  }
}
