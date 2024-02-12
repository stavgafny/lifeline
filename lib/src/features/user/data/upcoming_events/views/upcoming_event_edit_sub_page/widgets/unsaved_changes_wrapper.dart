import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/upcoming_event_controller.dart';

class UnsavedChangesWrapper extends ConsumerWidget {
  final UpcomingEventProvider upcomingEvent;
  final UpcomingEventProvider editProvider;
  final Widget child;

  const UnsavedChangesWrapper({
    super.key,
    required this.upcomingEvent,
    required this.editProvider,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final originalModel = ref.watch(upcomingEvent);
    final areEqual = ref.watch(
      editProvider.select((model) => model == originalModel),
    );

    return PopScope(
      canPop: areEqual,
      onPopInvoked: (didPop) {
        if (!didPop) {
          showDialog(
            context: context,
            builder: (context) => _UnsavedChangesDialog(
              onCancel: () => Navigator.of(context).pop(),
              onDiscard: () {
                Navigator.of(context)
                  ..pop()
                  ..pop();
              },
            ),
          );
        }
      },
      child: child,
    );
  }
}

// enum _ConfirmState

class _UnsavedChangesDialog extends Dialog {
  final void Function() onCancel;
  final void Function() onDiscard;

  const _UnsavedChangesDialog({
    required this.onCancel,
    required this.onDiscard,
  });

  @override
  Widget build(BuildContext context) {
    final cancelButton = OutlinedButton(
      onPressed: onCancel,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2.0,
        ),
      ),
      child: const Text(
        'Cancel',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    final discardButton = ElevatedButton(
      onPressed: onDiscard,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Text(
        "Discard",
        style: TextStyle(
          color: Theme.of(context).dialogBackgroundColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    return AlertDialog(
      title: const Text(
        "Unsaved Changes",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("You have made changes."),
          Text("Do you want to discard them?"),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [cancelButton, discardButton],
    );
  }
}
