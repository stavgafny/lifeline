import 'package:flutter/material.dart';

/// Dialog for editing the goal tracker name
///
/// [name] -> the current goal tracker name
///
/// [onCancel] -> callback function when exiting the dialog with cancel
///
/// [onConfirm] -> callback function for confirm action
/// callback has the modified name passed as an argument
///
/// [startSelected] -> select all name text at start
///
/// Defaults to true.
///
/// Note that confirm can only be called if current [modifiedName] is not empty
class NameEditDialog extends StatefulWidget {
  final TextEditingController controller;
  final void Function() onCancel;
  final void Function(String modifiedName) onConfirm;

  /// Create [TextEditingController] form given name and if [startSelected] is
  /// true set the controller selection to select the whole name text
  NameEditDialog({
    super.key,
    required String name,
    required this.onCancel,
    required this.onConfirm,
    bool startSelected = true,
  }) : controller = TextEditingController(text: name) {
    if (startSelected) {
      controller.selection =
          TextSelection(baseOffset: 0, extentOffset: name.length);
    }
  }

  @override
  State<NameEditDialog> createState() => _NameEditDialogState();
}

class _NameEditDialogState extends State<NameEditDialog> {
  /// Determines whether can be confirmed
  ///
  /// If false, [onConfirm] won't be called and the confirm button text color
  /// will be set as disabled
  bool enabled = false;

  /// updates [enabled] value to the current controller text value
  /// whether its empty or not.
  ///
  /// [enabled] = controller text not empty
  ///
  /// Only if the condition isn't the same as [enabled], then setState is called
  /// to reduce unnecessary rebuilds
  void _updateEnabled() {
    final isNotEmpty = widget.controller.text.trim().isNotEmpty;
    if (enabled == isNotEmpty) return;
    setState(() => enabled = isNotEmpty);
  }

  @override
  void initState() {
    // Updates enabled on start once and then for every controller text change
    _updateEnabled();
    widget.controller.addListener(_updateEnabled);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the text controller when the dialog is dismissed
    widget.controller.removeListener(_updateEnabled);
    widget.controller.dispose();
    super.dispose();
  }

  @override
  AlertDialog build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: TextField(
        controller: widget.controller,
        autofocus: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Name',
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: widget.onCancel,
          child: Text(
            "Cancel",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        MaterialButton(
          onPressed: enabled
              ? () => widget.onConfirm.call(widget.controller.text.trim())
              : null,
          textColor: enabled ? Theme.of(context).colorScheme.primary : null,
          disabledTextColor: Theme.of(context).disabledColor,
          child: const Text("OK"),
        ),
      ],
    );
  }
}
