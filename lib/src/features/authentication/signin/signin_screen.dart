import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../shared/widgets/loading_sheet.dart';
import '../shared/widgets/header.dart';
import './widgets/email_field.dart';
import './widgets/password_field.dart';
import './widgets/forgot_password.dart';
import './widgets/or_divider.dart';
import './widgets/signin_button.dart';
import './widgets/google_signin_button.dart';
import './widgets/no_account_signup.dart';
import 'controllers/signin_controller.dart';

class SigninScreen extends ConsumerWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SigninState>(signinProvider, (previous, current) {
      if (current.status == FormSubmissionStatus.progress &&
          previous?.status != FormSubmissionStatus.progress) {
        LoadingSheet.show(context);
      } else if (current.status == FormSubmissionStatus.failure) {
        Navigator.maybePop(context);
        print("Error ${current.errorMessage}");
      } else if (current.status == FormSubmissionStatus.success) {
        Navigator.maybePop(context);
      }
    });

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
