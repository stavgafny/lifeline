import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared/widgets/header.dart';
import '../shared/widgets/text_input.dart';
import './widgets/signup_button.dart';
import './widgets/has_account_signin.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

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
                  title: "Get Onboard!",
                  info: "Let the adventure begin!",
                ),
                SizedBox(height: 30.0),
                TextInput.name(),
                SizedBox(height: 10.0),
                TextInput.email(),
                SizedBox(height: 10.0),
                TextInput.password(autofillHints: [AutofillHints.newPassword]),
                SizedBox(height: 25.0),
                SignupButton(),
                HasAccountSignin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
