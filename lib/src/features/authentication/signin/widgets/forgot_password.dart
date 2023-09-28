import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../router/routes/app_routes.dart';
import '../../shared/widgets/text_link.dart';
import '../controllers/signin_controller.dart';

class ForgotPassword extends ConsumerWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 8, 0),
      child: Align(
        alignment: Alignment.topRight,
        child: TextLink(
          text: "Forgot Password",
          onTap: () {
            ref.read(signinProvider.notifier).clear();
            context.pushReplacement(AppRoutes.signin);
            context.push(AppRoutes.forgotPassword);
          },
        ),
      ),
    );
  }
}
