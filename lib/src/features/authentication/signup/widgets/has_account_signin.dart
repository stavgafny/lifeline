import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../router/routes/app_routes.dart';
import '../../shared/widgets/text_link.dart';

class HasAccountSignin extends StatelessWidget {
  const HasAccountSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Already have account? ",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          TextLink(
            text: "Sign In",
            fontWeight: FontWeight.bold,
            onTap: () => context.go(AppRoutes.signin),
          ),
        ],
      ),
    );
  }
}
