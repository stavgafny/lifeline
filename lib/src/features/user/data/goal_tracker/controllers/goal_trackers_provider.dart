import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/features/user/data/goal_tracker/models/goal_tracker_model.dart';
import './goal_tracker_controller.dart';

final goalTrackersProvider = StateProvider<List<GoalTrackerProvider>>((ref) {
  final goalTrackers = [
    const GoalTrackerModel(
      name: "A",
      duration: Duration(hours: 1),
      progress: Duration(seconds: 3),
    ),
    GoalTrackerModel(
      name: "B",
      duration: const Duration(hours: 2),
      progress: const Duration(),
      playTimestamp: DateTime.now(),
    ),
  ];

  return goalTrackers
      .map((goalTracker) =>
          GoalTrackerProvider((ref) => GoalTrackerController(goalTracker)))
      .toList();
});
