import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;

  const TextInput({
    super.key,
    this.controller,
    this.hintText = "",
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
  });

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
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  static TextInput email({TextEditingController? controller}) {
    return TextInput(
      controller: controller,
      hintText: "Email",
      prefixIcon: const Icon(Icons.email_outlined),
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
    );
  }

  static TextInput password({
    TextEditingController? controller,
    bool confirm = false,
  }) {
    return TextInput(
      controller: controller,
      hintText: "${confirm ? 'Confirm ' : ''}Password",
      prefixIcon: const Icon(Icons.lock_outline_rounded),
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      autofillHints: const [AutofillHints.password],
    );
  }
}
