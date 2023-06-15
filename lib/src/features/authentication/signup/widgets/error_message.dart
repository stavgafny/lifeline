import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/widgets/error_box.dart';
import '../controllers/signup_controller.dart';

class ErrorMessage extends ConsumerWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref.watch(signupProvider).errorMessage;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          message == null
              ? const SizedBox(height: 15.0)
              : SizedBox(height: 50.0, child: ErrorBox(message: message)),
        ],
      ),
    );
  }
}
