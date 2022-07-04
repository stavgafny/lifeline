import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final String text;
  final bool condition;
  final void Function()? onPressed;
  const LoadingButton({
    Key? key,
    required this.text,
    required this.condition,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: const ButtonStyle(
        animationDuration: Duration(seconds: 0),
        splashFactory: NoSplash.splashFactory,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: condition
            ? CircularProgressIndicator(
                strokeWidth: 3.5,
                color: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.surface,
              )
            : Text(text),
      ),
    );
  }
}
