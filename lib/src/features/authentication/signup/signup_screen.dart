import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import '../shared/widgets/loading_sheet.dart';
import '../shared/widgets/header.dart';
import './widgets/name_field.dart';
import './widgets/email_field.dart';
import './widgets/password_field.dart';
import './widgets/signup_button.dart';
import './widgets/has_account_signin.dart';
import './controllers/signup_controller.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignupState>(signupProvider, (previous, current) {
      if (current.status == FormSubmissionStatus.progress) {
        LoadingSheet.show(context);
      } else if (current.status == FormSubmissionStatus.failure) {
        Navigator.of(context).maybePop();
        print("Error");
      } else if (current.status == FormSubmissionStatus.success) {
        Navigator.of(context).maybePop();
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(forceMaterialTransparency: true),
      body: const Padding(
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
    );
  }
}
