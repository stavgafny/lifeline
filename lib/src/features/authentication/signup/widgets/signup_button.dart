import 'package:flutter/material.dart';
import '../../shared/widgets/submit_button.dart';
import '../../shared/widgets/loading_sheet.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SubmitButton(
      text: "Sign Up",
      onPressed: () {
        LoadingSheet.show(context);
      },
    );
  }
}
