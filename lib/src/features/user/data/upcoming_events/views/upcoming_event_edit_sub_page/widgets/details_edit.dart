import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/upcoming_event_controller.dart';

class DetailsEdit extends ConsumerStatefulWidget {
  final UpcomingEventProvider editProvider;
  final void Function(bool isFocused) onFocusChange;

  const DetailsEdit({
    super.key,
    required this.editProvider,
    required this.onFocusChange,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailsEditState();
}

class _DetailsEditState extends ConsumerState<DetailsEdit> {
  final _focusNode = FocusNode();
  late final _controller = TextEditingController(
    text: ref.read(widget.editProvider).details,
  );

  void _onFocusChanges() => widget.onFocusChange.call(_focusNode.hasFocus);

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanges);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        child: TextFormField(
          focusNode: _focusNode,
          controller: _controller,
          onChanged: (value) {
            ref.read(widget.editProvider.notifier).setDetails(details: value);
          },
          maxLines: null,
          minLines: null,
          expands: true,
          keyboardType: TextInputType.multiline,
          magnifierConfiguration: TextMagnifierConfiguration.disabled,
          style: const TextStyle(fontSize: 16.0),
          decoration: const InputDecoration(
            hintText: 'Add event details here...',
            contentPadding: EdgeInsets.all(10.0),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanges);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
