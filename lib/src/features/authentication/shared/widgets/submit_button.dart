import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const SubmitButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
