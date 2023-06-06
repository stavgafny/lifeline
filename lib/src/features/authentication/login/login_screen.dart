import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../shared/widgets/header.dart';
import '../shared/widgets/text_input.dart';
import '../shared/widgets/submit_button.dart';
import './widgets/forgot_password.dart';
import './widgets/or_text_divider.dart';
import './widgets/google_sign_button.dart';
import './widgets/no_account_sign_up.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                const Header(
                  title: "Hi There!",
                  info: "Looks like you aren't logged in",
                ),
                const SizedBox(height: 30.0),
                TextInput.email(),
                const SizedBox(height: 10.0),
                TextInput.password(),
                const ForgotPassword(),
                const SizedBox(height: 25.0),
                SubmitButton(
                  text: "Sign In",
                  onPressed: () {
                    context.go("/forgot-password");
                  },
                ),
                const SizedBox(height: 10.0),
                const OrTextDivider(),
                const SizedBox(height: 10.0),
                const GoogleSignButton(),
                const NoAccountSignUp(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
