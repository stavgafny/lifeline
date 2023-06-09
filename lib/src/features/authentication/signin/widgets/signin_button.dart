import 'package:flutter/material.dart';
import '../../shared/widgets/submit_button.dart';
import '../../shared/widgets/loading_sheet.dart';

class SigninButton extends StatelessWidget {
  const SigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SubmitButton(
      text: "Sign In",
      onPressed: () {
        LoadingSheet.show(context);
      },
    );
  }
}
