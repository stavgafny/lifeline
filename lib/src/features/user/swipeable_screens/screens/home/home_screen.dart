import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../router/providers/guards/auth_state_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authStateProvider.notifier);
    final authUser = ref.watch(authStateProvider).user;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("User id: ${authUser.id}"),
            Text("User name: ${authUser.name}"),
            Text("User email: ${authUser.email}"),
            Text("User verified: ${authUser.emailVerified}"),
            TextButton(
              onPressed: () async => authController.onSignOut(),
              child: const Text("Sign Out"),
            )
          ],
        ),
      ),
    );
  }
}
