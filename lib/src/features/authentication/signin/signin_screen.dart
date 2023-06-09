import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared/widgets/loading_sheet.dart';
import '../shared/widgets/header.dart';
import '../shared/widgets/text_input.dart';
import '../shared/widgets/submit_button.dart';
import './widgets/forgot_password.dart';
import './widgets/or_divider.dart';
import './widgets/google_signin_button.dart';
import './widgets/no_account_signup.dart';

class SigninScreen extends ConsumerWidget {
  const SigninScreen({super.key});

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
                  info: "Looks like you aren't signed in",
                ),
                const SizedBox(height: 30.0),
                const TextInput.email(),
                const SizedBox(height: 10.0),
                const TextInput.password(),
                const ForgotPassword(),
                const SizedBox(height: 25.0),
                SubmitButton(
                  text: "Sign In",
                  onPressed: () {
                    LoadingSheet.show(context);
                  },
                ),
                const OrDivider(),
                const GoogleSigninButton(),
                const NoAccountSignup(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
