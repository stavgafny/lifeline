import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/text_input.dart';
import '../controllers/signin_controller.dart';

class PasswordField extends ConsumerWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signinState = ref.watch(signinProvider);
    final controller = ref.read(signinProvider.notifier);
    final error = signinState.password.error;

    return TextInput.password(
      errorText: PasswordValidator.getErrorMessage(error),
      onChanged: error != null ? controller.onPasswordChange : null,
      onBlur: (value) => controller.validatePassword(value),
    );
  }
}
