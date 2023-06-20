import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../router/providers/guards/auth_state_provider.dart';

class EmailSentText extends ConsumerWidget {
  const EmailSentText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider.select((p) => p.user));
    final email = user.email.toString();
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Confirmation email sent to:"),
          const SizedBox(height: 5.0),
          Text(email, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
