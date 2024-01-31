import 'package:flutter/material.dart';

class UndoSnackBar {
  static const _defaultDuration = Duration(milliseconds: 2500);
  static const _defaultShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
  );

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?
      _lastInstance;

  static void clear() {
    _lastInstance?.close();
    _lastInstance = null;
  }

  final String text;
  final void Function(bool undoPressed) onUndoResult;
  final Duration duration;
  final ShapeBorder shape;

  const UndoSnackBar({
    required this.text,
    required this.onUndoResult,
    this.duration = _defaultDuration,
    this.shape = _defaultShape,
  });

  SnackBar get _snackBar => SnackBar(
        content: Text(text, overflow: TextOverflow.ellipsis, maxLines: 1),
        duration: duration,
        shape: shape,
        action: SnackBarAction(
          label: "Undo",
          onPressed: () => onUndoResult(true),
        ),
      );

  /// Display snack bar widget built from instance properties
  ///
  /// If override is set to true, override and remove current shown snack bar
  ///
  /// Returns snack bar widget controller for closed reason callbacks
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> display(
      BuildContext context,
      {bool override = false}) {
    if (override) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
    final snackbar = ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    snackbar.closed.then((SnackBarClosedReason reason) {
      // If last instance closed then remove it
      _lastInstance = null;

      // If undo was pressed, restore goal tracker
      // else, remove goal tracker completely and dispose it after
      if (reason != SnackBarClosedReason.action) {
        onUndoResult(false);
      }
    });
    _lastInstance = snackbar;
    return snackbar;
  }
}