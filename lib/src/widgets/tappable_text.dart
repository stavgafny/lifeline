import 'package:flutter/material.dart';

class TappableText extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final TextStyle style;
  const TappableText({
    super.key,
    required this.text,
    this.onTap,
    this.style = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary.withAlpha(75),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(text, style: style),
      ),
    );
  }
}
