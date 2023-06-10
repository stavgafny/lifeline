import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final void Function(String value)? onChanged;
  final void Function(String value)? onBlur;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;

  const TextInput({
    super.key,
    this.onChanged,
    this.onBlur,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
  });

  const TextInput.name({
    super.key,
    this.onChanged,
    this.onBlur,
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
    this.onBlur,
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
    this.onBlur,
    this.hintText = "Password",
    this.errorText,
    this.prefixIcon = const Icon(Icons.lock_outline_rounded),
    this.obscureText = true,
    this.keyboardType = TextInputType.visiblePassword,
    this.autofillHints = const [AutofillHints.password],
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.onBlur != null) {
      _focusNode.addListener(() {
        if (!_focusNode.hasFocus) {
          widget.onBlur?.call(_controller.text);
        }
      });
    }
  }

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
      controller: _controller,
      onChanged: widget.onChanged,
      focusNode: _focusNode,
      textInputAction: TextInputAction.next,
      autofillHints: widget.autofillHints,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      enableSuggestions: false,
      autocorrect: false,
      style: const TextStyle(fontWeight: FontWeight.bold),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.tertiary,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        border: mainBorder,
        enabledBorder: widget.errorText != null ? errorBorder : null,
        focusedBorder: widget.errorText != null ? errorBorder : null,
        labelText: widget.errorText,
        labelStyle: TextStyle(color: errorBorder.borderSide.color),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(horizontal: 22.0),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
