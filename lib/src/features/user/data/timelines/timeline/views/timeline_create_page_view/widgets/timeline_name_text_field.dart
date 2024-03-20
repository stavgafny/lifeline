import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../controllers/timelines_controllers.dart';
import '../../../controllers/timeline_create_controller.dart';

class TimelineNameTextField extends ConsumerWidget {
  static const _textStyle = TextStyle(fontSize: 24.0);

  final TimelineCreateProvider timeline;

  const TimelineNameTextField({super.key, required this.timeline});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final border = _inputBorder(context);

    final name = ref.watch(timeline.select((t) => t.name));
    final nameExists = ref.watch(timelinesProvider.notifier).nameExists(name);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _nameLabel(context),
        const SizedBox(width: 8.0),
        Expanded(
          child: TextFormField(
            autofocus: true,
            initialValue: ref.read(timeline).name,
            onChanged: (name) => ref.read(timeline.notifier).setName(name),
            style: _textStyle,
            decoration: InputDecoration(
              contentPadding: EdgeInsetsDirectional.zero,
              enabledBorder: border,
              focusedBorder: border,
              errorText: nameExists ? "Name already exists" : null,
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _nameLabel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
        "Name:",
        style: _textStyle.copyWith(color: Theme.of(context).hintColor),
      ),
    );
  }

  InputBorder _inputBorder(BuildContext context) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).iconTheme.color!),
    );
  }
}
