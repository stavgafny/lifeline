import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../router/providers/guards/auth_state_provider.dart';
import '../../shared/widgets/text_link.dart';

class SwitchAccountLink extends ConsumerWidget {
  const SwitchAccountLink({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authStateProvider.notifier);

    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TextLink(
          text: "Switch Account",
          onTap: controller.onSignOut,
        ),
      ),
    );
  }
}
