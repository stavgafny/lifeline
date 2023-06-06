import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final void Function()? onTap;

  const TextLink({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(color: Colors.blue, fontWeight: fontWeight),
      ),
    );
  }
}
