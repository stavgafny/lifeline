import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/features/user/data/goal_tracker/models/goal_tracker_model.dart';
import 'package:lifeline/src/utils/playable_duration.dart';
import '../../controllers/goal_trackers_controller.dart';
import '../goal_tracker_card/goal_tracker_card.dart';

class GoalTrackersListView extends ConsumerWidget {
  const GoalTrackersListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(goalTrackersProvider).when(
          data: (goalTrackers) {
            return Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: ReorderableListView(
                header: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final provider = goalTrackers[0];
                        ref
                            .read(goalTrackersProvider.notifier)
                            .remove(provider);
                        ref.read(provider.notifier).dispose();
                      },
                      child: const Text("rm [0]"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(goalTrackersProvider.notifier).add(
                              GoalTrackerModel(
                                name: "B",
                                duration: const Duration(),
                                progress: PlayableDuration.zero,
                              ),
                            );
                      },
                      child: const Text("Add"),
                    ),
                  ],
                ),
                children: goalTrackers
                    .map(
                      (goalTracker) => GoalTrackerCard(
                        key: ValueKey(goalTracker),
                        provider: goalTracker,
                      ),
                    )
                    .toList(),
                onReorder: (oldIndex, newIndex) {
                  ref.read(goalTrackersProvider.notifier).swap(
                        oldIndex,
                        newIndex,
                      );
                },
                proxyDecorator: (child, i, a) => Material(child: child),
              ),
            );
          },
          error: (error, stackTrace) => const Text("error"),
          loading: () => const CircularProgressIndicator(),
        );
  }
}
