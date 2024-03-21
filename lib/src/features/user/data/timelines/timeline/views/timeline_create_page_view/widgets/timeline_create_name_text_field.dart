import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/timeline_create_controller.dart';

class TimelineCreateNameTextField extends ConsumerWidget {
  static const _textStyle = TextStyle(fontSize: 24.0);

  final TimelineCreateProvider timelineCreate;

  const TimelineCreateNameTextField({super.key, required this.timelineCreate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameExists = ref.watch(timelineCreate.select((t) => t.nameExists));

    final border = _inputBorder(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _nameLabel(context),
        const SizedBox(width: 8.0),
        Expanded(
          child: TextFormField(
            initialValue: ref.read(timelineCreate).name,
            onChanged: (name) =>
                ref.read(timelineCreate.notifier).setName(name),
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
