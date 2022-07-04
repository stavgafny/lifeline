import 'package:flutter/material.dart';

class Entry extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final bool obscureText;
  const Entry({
    Key? key,
    this.controller,
    this.hintText = "",
    this.prefixIcon,
    this.autofillHints,
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
          controller: controller,
          textInputAction: TextInputAction.next,
          autofillHints: autofillHints,
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

  static Entry email(TextEditingController? controller) {
    return Entry(
      controller: controller,
      hintText: "Email",
      autofillHints: const [AutofillHints.email],
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.email_outlined),
    );
  }

  static Entry password(TextEditingController? controller,
      {bool confirm = false}) {
    return Entry(
      controller: controller,
      hintText: "${confirm ? "Confirm " : ''}Password",
      autofillHints: const [AutofillHints.password],
      keyboardType: TextInputType.visiblePassword,
      prefixIcon: const Icon(Icons.lock_outline_rounded),
      obscureText: true,
    );
  }
}
