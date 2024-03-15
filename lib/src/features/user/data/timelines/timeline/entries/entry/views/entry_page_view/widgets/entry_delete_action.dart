import 'package:flutter/material.dart';
import './dialogs/delete_entry_dialog.dart';

class EntryDeleteAction extends StatelessWidget {
  final void Function() onDelete;

  const EntryDeleteAction({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => DeleteEntryDialog(
            onDelete: () {
              Navigator.of(context)
                ..pop()
                ..pop();
              onDelete.call();
            },
            onCancel: () => Navigator.of(context).pop(),
          ),
        );
      },
      icon: const Icon(Icons.delete_forever),
    );
  }
}
