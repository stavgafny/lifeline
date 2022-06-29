import 'package:flutter/material.dart';

class Entry extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  const Entry({
    Key? key,
    this.hintText = "",
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: TextField(
          keyboardType: keyboardType,
          obscureText: obscureText,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            prefixIcon: prefixIcon,
          ),
        ),
      ),
    );
  }

  static Entry get email {
    return const Entry(
      hintText: "Email",
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icon(Icons.email_outlined),
    );
  }

  static Entry get password {
    return const Entry(
      hintText: "Password",
      keyboardType: TextInputType.visiblePassword,
      prefixIcon: Icon(Icons.lock_outline_rounded),
      obscureText: true,
    );
  }
}
