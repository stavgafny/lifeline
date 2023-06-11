import 'package:flutter/material.dart';
import '../shared/widgets/header.dart';
import './widgets/email_field.dart';
import './widgets/password_field.dart';
import './widgets/forgot_password.dart';
import './widgets/or_divider.dart';
import './widgets/signin_button.dart';
import './widgets/google_signin_button.dart';
import './widgets/no_account_signup.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: [
              Header(
                title: "Hi There!",
                info: "Looks like you aren't signed in",
              ),
              SizedBox(height: 30.0),
              EmailField(),
              SizedBox(height: 10.0),
              PasswordField(),
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
    );
  }
}
