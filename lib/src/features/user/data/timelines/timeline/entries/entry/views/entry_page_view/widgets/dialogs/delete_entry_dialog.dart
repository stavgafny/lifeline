import 'package:flutter/material.dart';
import 'package:lifeline/src/widgets/dialogs/core/dialog_action_buttons_builder.dart';

class DeleteEntryDialog extends Dialog {
  final void Function() onDelete;
  final void Function() onCancel;

  const DeleteEntryDialog({
    super.key,
    required this.onDelete,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(bottom: 20.0),
      title: const Text(
        "Delete Entry?",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.delete_forever, size: 50.0),
          ),
          Text("Delete this entry from timeline?"),
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
