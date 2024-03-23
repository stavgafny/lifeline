import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UndoSnackBar {
  static const _defaultDuration = Duration(milliseconds: 2500);
  static const _defaultShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
  );

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

    void clearOnContextChange() {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    }

    GoRouter.of(context).addListener(clearOnContextChange);

    final snackbar = ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    snackbar.closed.then((SnackBarClosedReason reason) {
      // If undo was pressed, restore goal tracker
      // else, remove goal tracker completely and dispose it after
      if (reason != SnackBarClosedReason.action) {
        onUndoResult(false);
      }

      GoRouter.of(context).removeListener(clearOnContextChange);
    });

    return snackbar;
  }
}
