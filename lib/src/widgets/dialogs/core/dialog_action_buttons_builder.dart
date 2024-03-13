import 'package:flutter/material.dart';

class DialogActionButtonsBuilder {
  static Widget buildMaterialAction({
    required String text,
    required void Function()? onAction,
  }) {
    return _MaterialAction(text, onAction);
  }

  static Widget buildOutlineAction({
    required String text,
    required void Function()? onAction,
  }) {
    return _OutlineAction(text, onAction);
  }

  static Widget buildElevatedAction({
    required String text,
    required void Function()? onAction,
  }) {
    return _ElevatedAction(text, onAction);
  }
}

class _MaterialAction extends StatelessWidget {
  final String text;
  final void Function()? onAction;
  const _MaterialAction(this.text, this.onAction);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onAction,
      textColor:
          onAction != null ? Theme.of(context).colorScheme.primary : null,
      disabledTextColor: Theme.of(context).disabledColor,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _OutlineAction extends StatelessWidget {
  final String text;
  final void Function()? onAction;
  const _OutlineAction(this.text, this.onAction);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onAction,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2.0,
        ),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class _ElevatedAction extends StatelessWidget {
  final String text;
  final void Function()? onAction;
  const _ElevatedAction(this.text, this.onAction);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onAction,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).dialogBackgroundColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
