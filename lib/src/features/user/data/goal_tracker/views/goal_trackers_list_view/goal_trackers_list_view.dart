import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/goal_trackers_provider.dart';
import '../goal_tracker_card/goal_tracker_card.dart';

class GoalTrackersListView extends ConsumerWidget {
  const GoalTrackersListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalTrackers = ref.watch(goalTrackersProvider);
    return ListView(
      children: goalTrackers
          .map((goalTracker) => GoalTrackerCard(provider: goalTracker))
          .toList(),
    );
  }
}
