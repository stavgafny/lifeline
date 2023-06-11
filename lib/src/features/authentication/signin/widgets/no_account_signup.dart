import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../router/routes/app_routes.dart';
import '../../shared/widgets/text_link.dart';

class NoAccountSignup extends StatelessWidget {
  const NoAccountSignup({super.key});

  @override
  Widget build(BuildContext context) {
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
            onTap: () => context.push(AppRoutes.signup),
          ),
        ],
      ),
    );
  }
}
