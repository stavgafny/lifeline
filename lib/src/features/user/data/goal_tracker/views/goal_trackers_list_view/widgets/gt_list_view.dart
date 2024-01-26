import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeline/src/features/user/data/goal_tracker/models/goal_tracker_model.dart';
import 'package:lifeline/src/widgets/snackbars.dart';
import 'package:lifeline/src/widgets/transitions.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../controllers/goal_tracker_select_controller.dart';
import '../../../controllers/goal_trackers_controller.dart';
import '../../goal_tracker_card/goal_tracker_card.dart';
import '../../goal_tracker_dialogs/goal_tracker_name_edit_dialog.dart';

class GTListView extends ConsumerWidget {
  final List<GoalTrackerProvider> goalTrackers;

  const GTListView({super.key, required this.goalTrackers});

  Widget _buildGoalTracker(GoalTrackerProvider goalTracker) {
    return Consumer(
      key: ValueKey(goalTracker),
      builder: (context, ref, child) {
        final transitionC = ref.read(goalTracker.notifier).transitionController;
        return Transitions.sizeFade(
          controller: transitionC,
          child: GoalTrackerCard(
            provider: goalTracker,
            onDelete: () async {
              final name = ref.read(goalTracker).name;
              UndoSnackBar(
                      text: "Removed $name",
                      onPressed: () {
                        transitionC.animateIn();
                      })
                  .display(context, override: true)
                  .closed
                  .then((SnackBarClosedReason reason) {
                // If undo was pressed, restore goal tracker
                // else, remove goal tracker completely and dispose it after
                if (reason != SnackBarClosedReason.action) {
                  ref.read(goalTrackersProvider.notifier).remove(goalTracker);
                  ref.read(goalTracker.notifier).dispose();
                }
              });

              await transitionC.animateOut();

              ref.read(goalTrackerSelectProvider.notifier).select(null);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: ReorderableListView(
            onReorder: (oldIndex, newIndex) {
              ref.read(goalTrackersProvider.notifier).swap(oldIndex, newIndex);
            },
            children: goalTrackers.map(_buildGoalTracker).toList(),
            proxyDecorator: (child, i, a) => Material(child: child),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5.0,
                backgroundColor: Theme.of(context).colorScheme.background,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => GoalTrackerNameEditDialog(
                    name: "",
                    onCancel: () => context.pop(),
                    onConfirm: (name) {
                      final goalTracker = ref
                          .read(goalTrackersProvider.notifier)
                          .create(GoalTrackerModel.empty(name: name));

                      if (goalTracker != null) {
                        ref
                            .read(goalTracker.notifier)
                            .transitionController
                            .animateOnStart = true;
                      }

                      context.pop();
                    },
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Icon(Icons.add, size: 32.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
