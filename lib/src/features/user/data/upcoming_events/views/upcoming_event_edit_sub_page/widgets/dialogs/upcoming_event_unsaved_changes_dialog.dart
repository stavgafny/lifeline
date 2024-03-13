import 'package:flutter/material.dart';
import 'package:lifeline/src/widgets/dialogs/core/dialog_action_buttons_builder.dart';

class UpcomingEventUnsavedChangesDialog extends Dialog {
  final void Function() onDiscard;
  final void Function() onCancel;

  const UpcomingEventUnsavedChangesDialog({
    super.key,
    required this.onDiscard,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Unsaved Changes",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("You have made changes."),
          Text("Do you want to discard them?"),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        DialogActionButtonsBuilder.buildOutlineAction(
          text: "Cancel",
          onAction: onCancel,
        ),
        DialogActionButtonsBuilder.buildElevatedAction(
          text: "Discard",
          onAction: onDiscard,
        ),
      ],
    );
  }
}
