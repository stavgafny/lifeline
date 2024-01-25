import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/widgets/transitions.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../controllers/goal_tracker_select_controller.dart';
import '../../../controllers/goal_trackers_controller.dart';
import '../../goal_tracker_card/goal_tracker_card.dart';

class GTListView extends ConsumerWidget {
  final List<GoalTrackerProvider> goalTrackers;

  const GTListView({super.key, required this.goalTrackers});

  Widget _buildGoalTracker(GoalTrackerProvider goalTracker) {
    final transitionController = TransitionController();
    return Consumer(
      key: ValueKey(goalTracker),
      builder: (context, ref, child) {
        return Transitions.sizeFade(
          controller: transitionController,
          child: GoalTrackerCard(
            provider: goalTracker,
            onDelete: () async {
              await transitionController.animateOut();
              ref.read(goalTrackerSelectProvider.notifier).select(null);
              ref.read(goalTrackersProvider.notifier).remove(goalTracker);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Theme(
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
    );
  }
}
