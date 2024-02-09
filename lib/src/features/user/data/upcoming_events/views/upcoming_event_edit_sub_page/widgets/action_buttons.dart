import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/features/user/data/upcoming_events/controllers/upcoming_events_controller.dart';
import '../../../controllers/upcoming_event_controller.dart';

class ActionButtons extends StatelessWidget {
  static const double _buttonsSize = 55.0;
  static const EdgeInsets _padding = EdgeInsets.only(
    left: 30.0,
    right: 30.0,
    bottom: 50.0,
    top: 20.0,
  );

  final UpcomingEventProvider upcomingEvent;
  final UpcomingEventProvider editProvider;
  final void Function() onDelete;

  const ActionButtons({
    super.key,
    required this.upcomingEvent,
    required this.editProvider,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _padding,
      child: SizedBox(
        height: _buttonsSize,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _DeleteButton(onDelete),
            _ApplyButton(upcomingEvent, editProvider),
          ],
        ),
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final void Function() onDelete;

  const _DeleteButton(this.onDelete);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.25,
      child: MaterialButton(
        onPressed: () {
          onDelete.call();
          Navigator.of(context).pop();
        },
        color: Colors.red,
        padding: EdgeInsets.zero,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Transform.scale(
            scale: .8,
            child: const FittedBox(
              fit: BoxFit.contain,
              child: Icon(
                Icons.delete_forever,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ApplyButton extends ConsumerWidget {
  static const _textStyle = TextStyle(fontSize: 28.0);

  final UpcomingEventProvider upcomingEvent;
  final UpcomingEventProvider editProvider;

  const _ApplyButton(this.upcomingEvent, this.editProvider);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingEvents = ref.watch(upcomingEventsProvider).value ?? [];
    final isNew = !upcomingEvents.contains(upcomingEvent);

    final hasChanges =
        isNew ? true : ref.watch(editProvider) != ref.watch(upcomingEvent);

    onChange() {
      ref.read(upcomingEvent.notifier).update(ref.read(editProvider));
      if (isNew) {
        ref.read(upcomingEventsProvider.notifier).autoInsert(upcomingEvent);
      }
    }

    return _button(
      context,
      text: isNew ? "Save" : "Apply",
      onPressed: hasChanges ? onChange : null,
    );
  }

  Widget _button(
    BuildContext context, {
    required String text,
    required final void Function()? onPressed,
  }) {
    return MaterialButton(
      onPressed: onPressed,
      height: double.infinity,
      elevation: 10.0,
      color: Theme.of(context).colorScheme.primary.withAlpha(200),
      disabledColor: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(child: Text(text, style: _textStyle)),
    );
  }
}
