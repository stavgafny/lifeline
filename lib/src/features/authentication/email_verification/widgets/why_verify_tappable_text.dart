import 'package:flutter/material.dart';

class WhyVerifyTappableText extends StatelessWidget {
  const WhyVerifyTappableText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary.withAlpha(50),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          "Why do I have to verify email?",
          style: TextStyle(fontSize: 12.0),
        ),
      ),
    );
  }
}
