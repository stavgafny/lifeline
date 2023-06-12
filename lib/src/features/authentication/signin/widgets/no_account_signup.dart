import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../router/routes/app_routes.dart';
import '../../shared/widgets/text_link.dart';
import '../controllers/signin_controller.dart';

class NoAccountSignup extends ConsumerWidget {
  const NoAccountSignup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(signinProvider.notifier);

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Don't have account? ",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          TextLink(
            text: "Sign Up",
            fontWeight: FontWeight.bold,
            onTap: () {
              context.pushReplacement(AppRoutes.signin);
              controller.clear();
              context.push(AppRoutes.signup);
            },
          ),
        ],
      ),
    );
  }
}
