import 'package:flutter/material.dart';

class LinkText extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const LinkText(
    this.text, {
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blue,
        ),
      ),
    );
  }
}
