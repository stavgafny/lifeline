import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/upcoming_event_controller.dart';

class NameEdit extends ConsumerStatefulWidget {
  final UpcomingEventProvider editProvider;

  const NameEdit({super.key, required this.editProvider});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NameEditState();
}

class _NameEditState extends ConsumerState<NameEdit> {
  late final _textController = TextEditingController(
    text: ref.read(widget.editProvider).name,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextField(
        controller: _textController,
        onChanged: (value) {
          ref.read(widget.editProvider.notifier).setName(name: value);
        },
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: "Name",
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
