import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/upcoming_event_controller.dart';
import './dialogs/upcoming_event_unsaved_changes_dialog.dart';

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
            builder: (context) => UpcomingEventUnsavedChangesDialog(
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
