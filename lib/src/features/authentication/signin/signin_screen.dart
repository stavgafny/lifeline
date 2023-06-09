import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared/widgets/header.dart';
import '../shared/widgets/text_input.dart';
import './widgets/forgot_password.dart';
import './widgets/or_divider.dart';
import './widgets/signin_button.dart';
import './widgets/google_signin_button.dart';
import './widgets/no_account_signup.dart';

class SigninScreen extends ConsumerWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(40.0),
            child: Column(
              children: [
                Header(
                  title: "Hi There!",
                  info: "Looks like you aren't signed in",
                ),
                SizedBox(height: 30.0),
                TextInput.email(),
                SizedBox(height: 10.0),
                TextInput.password(),
                ForgotPassword(),
                SizedBox(height: 25.0),
                SigninButton(),
                OrDivider(),
                GoogleSigninButton(),
                NoAccountSignup(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
