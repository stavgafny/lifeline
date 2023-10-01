import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/goal_trackers_provider.dart';
import '../goal_tracker_card/goal_tracker_card.dart';

class GoalTrackersListView extends ConsumerWidget {
  const GoalTrackersListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalTrackers = ref.watch(goalTrackersProvider);
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: ReorderableListView(
        children: goalTrackers
            .map((goalTracker) => GoalTrackerCard(
                  key: ValueKey(ref.read(goalTracker.notifier).id),
                  provider: goalTracker,
                ))
            .toList(),
        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) newIndex--;
          final current = ref.read(goalTrackersProvider.notifier).state;
          current.insert(newIndex, current.removeAt(oldIndex));
          ref.read(goalTrackersProvider.notifier).state = [...current];
        },
        proxyDecorator: (child, i, a) => Material(child: child),
      ),
    );
  }
}
