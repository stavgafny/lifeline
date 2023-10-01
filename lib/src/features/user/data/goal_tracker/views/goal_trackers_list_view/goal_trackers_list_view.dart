import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/goal_trackers_controller.dart';
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
        header: ElevatedButton(
          onPressed: () {
            final provider = goalTrackers.providers[0];
            ref.read(goalTrackersProvider.notifier).remove(provider);
            ref.read(provider.notifier).dispose();
          },
          child: const Text("rm [0]"),
        ),
        children: goalTrackers.providers
            .map(
              (goalTracker) => GoalTrackerCard(
                key: ValueKey(ref.read(goalTracker.notifier).id),
                provider: goalTracker,
              ),
            )
            .toList(),
        onReorder: (oldIndex, newIndex) {
          ref.read(goalTrackersProvider.notifier).swap(oldIndex, newIndex);
        },
        proxyDecorator: (child, i, a) => Material(child: child),
      ),
    );
  }
}
