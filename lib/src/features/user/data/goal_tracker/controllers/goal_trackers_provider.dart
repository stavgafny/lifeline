import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/features/user/data/goal_tracker/models/goal_tracker_model.dart';
import 'package:lifeline/src/utils/playable_duration.dart';
import './goal_tracker_controller.dart';

final goalTrackersProvider = StateProvider<List<GoalTrackerProvider>>((ref) {
  final goalTrackers = [
    const GoalTrackerModel(
      name: "A",
      duration: Duration(hours: 1),
      progress: PlayableDuration.paused(duration: Duration()),
    ),
    GoalTrackerModel(
      name: "B",
      duration: const Duration(hours: 1),
      progress: PlayableDuration.playing(
          timestamp: DateTime.now().subtract(const Duration(minutes: 1))),
    ),
  ];

  return goalTrackers
      .map((goalTracker) =>
          GoalTrackerProvider((ref) => GoalTrackerController(goalTracker)))
      .toList();
});
