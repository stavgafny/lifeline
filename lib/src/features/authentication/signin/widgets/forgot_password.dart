import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../router/routes/app_routes.dart';
import '../../shared/widgets/text_link.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 8, 0),
      child: Align(
        alignment: Alignment.topRight,
        child: TextLink(
          text: "Forgot Password",
          onTap: () => context.push(AppRoutes.forgotPassword),
        ),
      ),
    );
  }
}
