import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/header.dart';
import '../widgets/text_input.dart';
import '../widgets/text_link.dart';
import '../widgets/sign_button.dart';
import '../widgets/text_divider.dart';
import '../widgets/google_sign_button.dart';

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
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 8, 0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextLink(text: "Forgot Password"),
                  ),
                ),
                const SizedBox(height: 25.0),
                SignButton(
                  text: "Sign In",
                  onPressed: () {},
                ),
                const SizedBox(height: 10.0),
                TextDivider(color: Theme.of(context).colorScheme.onSecondary),
                const SizedBox(height: 10.0),
                const GoogleSignButton(),
                Expanded(
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
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
