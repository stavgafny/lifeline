import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final void Function(String value)? onChanged;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;

  const TextInput({
    super.key,
    this.onChanged,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    final mainBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide.none,
    );
    final errorBorder = mainBorder.copyWith(
      borderSide: const BorderSide(width: 2, color: Colors.red),
    );

    return TextField(
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      autofillHints: autofillHints,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enableSuggestions: false,
      autocorrect: false,
      style: const TextStyle(fontWeight: FontWeight.bold),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
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

  const TextInput.name({
    super.key,
    this.onChanged,
    this.hintText = "Name",
    this.errorText,
    this.prefixIcon = const Icon(Icons.person),
    this.obscureText = false,
    this.keyboardType = TextInputType.name,
    this.autofillHints = const [AutofillHints.name],
  });

  const TextInput.email({
    super.key,
    this.onChanged,
    this.hintText = "Email",
    this.errorText,
    this.prefixIcon = const Icon(Icons.email_outlined),
    this.obscureText = false,
    this.keyboardType = TextInputType.emailAddress,
    this.autofillHints = const [AutofillHints.email],
  });

  const TextInput.password({
    super.key,
    this.onChanged,
    this.hintText = "Password",
    this.errorText,
    this.prefixIcon = const Icon(Icons.lock_outline_rounded),
    this.obscureText = true,
    this.keyboardType = TextInputType.visiblePassword,
    this.autofillHints = const [AutofillHints.password],
  });
}
