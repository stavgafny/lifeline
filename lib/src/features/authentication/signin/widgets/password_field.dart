import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../../shared/widgets/text_input.dart';
import '../controllers/signin_controller.dart';

/// Note that [onSubmit] dismisses the keyboard and by that also calls [onBlur]
/// This may cause a conflict of controller state setting status in progress and
/// calling [onBlur] callback that has `.copyWith`, it sets status to progress
/// again, making two calls on progress.
/// To avoid this behaviour the screen filters duplicate progress status
class PasswordField extends ConsumerWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signinState = ref.watch(signinProvider);
    final controller = ref.watch(signinProvider.notifier);
    final error = signinState.password.error;

    return TextInput.password(
      errorText: PasswordValidator.getErrorMessage(error),
      onChanged: controller.onPasswordChange,
      onBlur: controller.validatePassword,
      onSubmit: (value) {
        FocusScope.of(context).unfocus();

        // Validate password for any change before signin
        controller.validatePassword(value);

        // To avoid keyboard dismiss conflicts
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.signinWithEmailAndPassword();
        });
      },
    );
  }
}
