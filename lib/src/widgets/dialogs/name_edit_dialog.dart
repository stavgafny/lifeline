import 'package:flutter/material.dart';

class NameEditDialog extends StatefulWidget {
  final String name;
  final void Function() onCancel;
  final void Function(String modifiedName) onConfirm;
  final bool startSelected;

  const NameEditDialog({
    super.key,
    required this.name,
    required this.onCancel,
    required this.onConfirm,
    this.startSelected = true,
  });

  @override
  State<NameEditDialog> createState() => _NameEditDialogState();
}

class _NameEditDialogState extends State<NameEditDialog> {
  static const _textStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
  );

  late final _controller = TextEditingController(text: widget.name);
  bool _enabled = false;

  void _updateEnabled() {
    final isNotEmpty = _controller.text.trim().isNotEmpty;
    if (_enabled == isNotEmpty) return;
    setState(() => _enabled = isNotEmpty);
  }

  @override
  void initState() {
    if (widget.startSelected) {
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: widget.name.length,
      );
    }
    _updateEnabled();
    _controller.addListener(_updateEnabled);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_updateEnabled);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textFieldInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 2.0,
      ),
    );
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: TextField(
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          focusedBorder: textFieldInputBorder,
          enabledBorder: textFieldInputBorder,
          label: const Text(
            "Name",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
          ),
        ),
        style: _textStyle,
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        MaterialButton(
          onPressed: widget.onCancel,
          textColor: Theme.of(context).colorScheme.primary,
          child: const Text("Cancel", style: _textStyle),
        ),
        MaterialButton(
          onPressed: _enabled
              ? () => widget.onConfirm.call(_controller.text.trim())
              : null,
          textColor: _enabled ? Theme.of(context).colorScheme.primary : null,
          disabledTextColor: Theme.of(context).disabledColor,
          child: const Text("OK", style: _textStyle),
        ),
      ],
    );
  }
}
