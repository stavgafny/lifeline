import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  static const double _buttonsSize = 55.0;
  static const EdgeInsets _padding = EdgeInsets.only(
    left: 30.0,
    right: 30.0,
    bottom: 50.0,
    top: 20.0,
  );

  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _padding,
      child: SizedBox(
        height: _buttonsSize,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _DeleteButton(onPressed: () {}),
            _ApplyButton(onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final void Function() onPressed;

  const _DeleteButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.25,
      child: MaterialButton(
        onPressed: onPressed,
        color: Colors.red,
        padding: EdgeInsets.zero,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Transform.scale(
            scale: .8,
            child: const FittedBox(
              fit: BoxFit.contain,
              child: Icon(
                Icons.delete_forever,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ApplyButton extends StatelessWidget {
  final void Function()? onPressed;

  const _ApplyButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: double.infinity,
      elevation: 10.0,
      color: Theme.of(context).colorScheme.primary.withAlpha(200),
      disabledColor: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Center(
        child: Text(
          "Apply",
          style: TextStyle(fontSize: 28.0),
        ),
      ),
    );
  }
}
