import 'package:flutter/material.dart';
import 'package:lifeline/src/features/user/data/goal_tracker/views/goal_tracker_card/goal_tracker_card.dart';
import '../../../controllers/goal_tracker_controller.dart';

class GTListView extends StatelessWidget {
  final List<GoalTrackerProvider> goalTrackers;
  final void Function(int oldIndex, int newIndex) onReorder;

  const GTListView({
    super.key,
    required this.goalTrackers,
    required this.onReorder,
  });

  Widget _buildGoalTracker(GoalTrackerProvider goalTracker) {
    return GoalTrackerCard(
      key: ValueKey(goalTracker),
      provider: goalTracker,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: ReorderableListView(
        onReorder: onReorder,
        children: goalTrackers.map(_buildGoalTracker).toList(),
        proxyDecorator: (child, i, a) => Material(child: child),
      ),
    );
  }
}
