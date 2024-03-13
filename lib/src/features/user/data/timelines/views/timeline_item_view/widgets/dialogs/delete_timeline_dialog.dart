import 'package:flutter/material.dart';
import 'package:lifeline/src/widgets/dialogs/core/dialog_action_buttons_builder.dart';

class DeleteTimelineDialog extends Dialog {
  final String timelineName;
  final void Function() onDelete;
  final void Function() onCancel;

  const DeleteTimelineDialog({
    super.key,
    required this.timelineName,
    required this.onDelete,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(bottom: 20.0),
      title: const Text(
        "Delete Timeline?",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.folder_delete,
            size: 40.0,
          ),
          const Text("This will permanently delete"),
          Text(
            "\"$timelineName\"",
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text("Do you want to delete?"),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        DialogActionButtonsBuilder.buildOutlineAction(
          text: "Cancel",
          onAction: onCancel,
        ),
        DialogActionButtonsBuilder.buildElevatedAction(
          text: "Delete",
          onAction: onDelete,
        ),
      ],
    );
  }
}
