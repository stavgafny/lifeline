import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/features/authentication/shared/widgets/text_link.dart';
import '../../../router/providers/guards/auth_state_provider.dart';
import '../shared/widgets/header.dart';

class EmailVerificationScreen extends ConsumerWidget {
  const EmailVerificationScreen({super.key});

  Widget _greeting(String name) {
    return Text(
      "Hey $name,",
      style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _contentInfo() {
    return const Text(
      "guess who sent you an email? That's right, it's us! Our email is on its way to give you a virtual high-five. Don't leave it hanging!",
      textAlign: TextAlign.center,
    );
  }

  Widget _email(String email) {
    return Column(
      children: [
        const Text("Confirmation email sent to:"),
        const SizedBox(height: 5.0),
        Text(email, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider.select((p) => p.user));
    final email = user.email.toString();
    final name = user.name.toString();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(forceMaterialTransparency: true),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Header(
                  title: "Email Fiesta",
                  info: "Pssst! Inbox secrets await verification!",
                ),
                const SizedBox(height: 35.0),
                _greeting(name),
                const SizedBox(height: 10.0),
                _contentInfo(),
              ],
            ),
            _email(email),
            TextLink(
              text: "......",
              onTap: () => ref.read(authStateProvider.notifier).onSignOut(),
            ),
          ],
        ),
      ),
    );
  }
}
