import 'package:flutter/material.dart';

class DetailsEdit extends StatefulWidget {
  static void displayEditPage(
    BuildContext context, {
    required String title,
    required String text,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            scrolledUnderElevation: 0.0,
            automaticallyImplyLeading: true,
            title: Row(
              children: [
                Text(
                  "Editing $title",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              DetailsEdit._(text: text, enabled: true, onTap: null),
            ],
          ),
        );
      },
    );
  }

  final String text;
  final bool enabled;
  final void Function()? onTap;
  const DetailsEdit._({
    required this.text,
    required this.enabled,
    required this.onTap,
  });

  const DetailsEdit.preview({super.key, required this.text, this.onTap})
      : enabled = false;

  @override
  State<DetailsEdit> createState() => _DetailsEditState();
}

class _DetailsEditState extends State<DetailsEdit> {
  late final _controller = TextEditingController(text: widget.text);
  final _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        child: TextField(
          focusNode: _focusNode,
          onTap: widget.enabled ? null : widget.onTap,
          maxLines: null,
          minLines: null,
          readOnly: !widget.enabled,
          enableInteractiveSelection: widget.enabled,
          magnifierConfiguration: TextMagnifierConfiguration.disabled,
          expands: true,
          controller: _controller,
          style: TextStyle(
            fontSize: 18.0,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          decoration: const InputDecoration(
            hintText: 'Event details',
            contentPadding: EdgeInsets.all(10.0),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
