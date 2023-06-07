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
    String? errorText = hintText == "Email" ? "Invalid Email" : null;

    final mainBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide.none,
    );
    final errorBorder = mainBorder.copyWith(
      borderSide: const BorderSide(width: 2, color: Colors.red),
    );

    return TextField(
      controller: controller,
      textInputAction: TextInputAction.next,
      autofillHints: autofillHints,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enableSuggestions: false,
      autocorrect: false,
      style: const TextStyle(fontWeight: FontWeight.bold),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isCollapsed: true,
        filled: true,
        fillColor: Theme.of(context).colorScheme.tertiary,
        hintText: hintText,
        prefixIcon: prefixIcon,
        border: mainBorder,
        enabledBorder: errorText != null ? errorBorder : null,
        focusedBorder: errorText != null ? errorBorder : null,
        labelText: errorText,
        labelStyle: TextStyle(color: errorBorder.borderSide.color),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(horizontal: 22.0),
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
