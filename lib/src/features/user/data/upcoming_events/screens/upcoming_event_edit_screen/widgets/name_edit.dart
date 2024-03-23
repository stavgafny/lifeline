import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;
import '../../../controllers/upcoming_event_controller.dart';

class NameEdit extends ConsumerStatefulWidget {
  static const defaultTextDirection = TextDirection.ltr;
  static const labelText = "Name";

  final UpcomingEventProvider editProvider;

  const NameEdit({super.key, required this.editProvider});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NameEditState();
}

class _NameEditState extends ConsumerState<NameEdit> {
  late final _textController = TextEditingController();
  TextDirection _textDirection = NameEdit.defaultTextDirection;

  @override
  void initState() {
    super.initState();
    final nameText = ref.read(widget.editProvider).name;
    _textController.text = nameText;
    _checkIfTextDirectionChanged(nameText);
  }

  void _checkIfTextDirectionChanged(String text) {
    final currentTextDirection = _getTextDirection(text);
    if (currentTextDirection != _textDirection) {
      setState(() => _textDirection = currentTextDirection);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextField(
        controller: _textController,
        onChanged: (value) {
          ref.read(widget.editProvider.notifier).setName(name: value);
          _checkIfTextDirectionChanged(value);
        },
        textDirection: _textDirection,
        style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: NameEdit.labelText,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).textTheme.bodyMedium!.color!,
            ),
          ),
          contentPadding: const EdgeInsets.all(6.0),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

TextDirection _getTextDirection(String text) {
  if (text.isEmpty) return NameEdit.defaultTextDirection;
  return intl.Bidi.detectRtlDirectionality(text)
      ? TextDirection.rtl
      : TextDirection.ltr;
}
