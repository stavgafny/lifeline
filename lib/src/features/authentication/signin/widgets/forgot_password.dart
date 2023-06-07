import 'package:flutter/material.dart';
import '../../shared/widgets/text_link.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 8, 0),
      child: Align(
        alignment: Alignment.topRight,
        child: TextLink(text: "Forgot Password"),
      ),
    );
  }
}
