import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../router/providers/guards/auth_state_provider.dart';

class TextSection extends ConsumerWidget {
  const TextSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider.select((p) => p.user));
    final name = user.name.toString();
    return Column(
      children: [
        Text(
          "Hey there $name,",
          maxLines: 1,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const Text(
          "guess who sent you an email? That's right, it's us! Our email is on its way to give you a virtual high-five. Don't leave it hanging!",
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20.0),
        const Text(
          "One small click for you, one giant leap for your account! Check your inbox and click the link to verify.",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
