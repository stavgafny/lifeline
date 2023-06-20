import 'package:flutter/material.dart';

class CheckSpamText extends StatelessWidget {
  const CheckSpamText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Don't let your verification email play hide-and-seek in the spam wilderness",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12.0,
        color: Colors.grey,
      ),
    );
  }
}
