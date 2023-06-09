import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/text_input.dart';
import '../controllers/signup_controller.dart';

class NameField extends ConsumerWidget {
  const NameField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupState = ref.watch(signupProvider);
    final hasError = signupState.name.invalid;
    final controller = ref.read(signupProvider.notifier);

    return TextInput.name(
      errorText: hasError
          ? NameValidator.getErrorMessage(signupState.name.error)
          : null,
      onChanged: (value) => controller.onNameChange(value),
    );
  }
}
