import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/text_input.dart';
import '../controllers/signup_controller.dart';

class NameField extends ConsumerWidget {
  const NameField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupStateError = ref
        .watch(signupProvider.select((signupState) => signupState.name.error));

    return TextInput.name(
      errorText: NameValidator.getErrorMessage(signupStateError),
      onChanged: ref.read(signupProvider.notifier).onNameChange,
      onBlur: ref.read(signupProvider.notifier).validateName,
    );
  }
}
