import 'package:flutter/material.dart';

/// Custom wrapper of a snack bar that provides a convenient
/// way to display a snack bar of type undo
class UndoSnackBar {
  static const _defaultDuration = Duration(milliseconds: 2500);
  static const _defaultShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
  );

  final String text;
  final void Function() onPressed;
  final Duration duration;
  final ShapeBorder shape;

  const UndoSnackBar({
    required this.text,
    required this.onPressed,
    this.duration = _defaultDuration,
    this.shape = _defaultShape,
  });

  SnackBar get _snackBar => SnackBar(
        content: Text(text, overflow: TextOverflow.ellipsis, maxLines: 1),
        duration: duration,
        shape: shape,
        action: SnackBarAction(
          label: "Undo",
          onPressed: onPressed,
        ),
      );

  /// Display snack bar widget built from instance properties
  ///
  /// If override is set to true, remove the current shown snack bar
  ///
  /// Returns snack bar widget controller for closed reason callbacks
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> display(
      BuildContext context,
      {bool override = false}) {
    if (override) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
    return ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }
}
