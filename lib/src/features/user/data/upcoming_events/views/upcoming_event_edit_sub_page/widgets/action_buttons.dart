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

  final UpcomingEventProvider originalModel;
  final UpcomingEventProvider editModel;

  const ActionButtons({
    super.key,
    required this.originalModel,
    required this.editModel,
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
            _DeleteButton(upcomingEvent: originalModel),
            _ApplyButton(originalModel: originalModel, editModel: editModel),
          ],
        ),
      ),
    );
  }
}

class _DeleteButton extends ConsumerWidget {
  final UpcomingEventProvider upcomingEvent;

  const _DeleteButton({required this.upcomingEvent});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AspectRatio(
      aspectRatio: 1.25,
      child: MaterialButton(
        onPressed: () {
          ref.read(upcomingEventsProvider.notifier).remove(upcomingEvent);
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

  final UpcomingEventProvider originalModel;
  final UpcomingEventProvider editModel;

  const _ApplyButton({required this.originalModel, required this.editModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasChanges = ref.watch(editModel) != ref.watch(originalModel);

    return MaterialButton(
      onPressed: hasChanges
          ? () {
              ref.read(originalModel.notifier).update(ref.read(editModel));
            }
          : null,
      height: double.infinity,
      elevation: 10.0,
      color: Theme.of(context).colorScheme.primary.withAlpha(200),
      disabledColor: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Center(child: Text("Apply", style: _textStyle)),
    );
  }
}
