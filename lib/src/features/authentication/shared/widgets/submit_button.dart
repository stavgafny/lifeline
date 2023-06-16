import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool disabled;
  const SubmitButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = disabled
        ? Theme.of(context).colorScheme.onSecondary
        : Theme.of(context).colorScheme.primary;

    return OutlinedButton(
      onPressed: !disabled
          ? () {
              FocusScope.of(context).unfocus();
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => onPressed?.call());
            }
          : null,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: color,
          width: 1.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      child: SizedBox(
        height: 55.0,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
