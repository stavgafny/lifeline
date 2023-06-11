import 'package:flutter/material.dart';
import '../shared/widgets/header.dart';
import './widgets/name_field.dart';
import './widgets/email_field.dart';
import './widgets/password_field.dart';
import './widgets/signup_button.dart';
import './widgets/has_account_signin.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                title: "Get Onboard!",
                info: "Let the adventure begin!",
              ),
              SizedBox(height: 30.0),
              NameField(),
              SizedBox(height: 10.0),
              EmailField(),
              SizedBox(height: 10.0),
              PasswordField(),
              SizedBox(height: 25.0),
              SignupButton(),
              HasAccountSignin(),
            ],
          ),
        ),
      ),
    );
  }
}
