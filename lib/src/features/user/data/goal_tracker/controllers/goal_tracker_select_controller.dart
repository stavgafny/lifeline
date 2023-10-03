import 'package:flutter_riverpod/flutter_riverpod.dart';
import './goal_tracker_controller.dart';

final goalTrackerSelectProvider =
    StateNotifierProvider<GoalTrackerSelectController, GoalTrackerProvider?>(
  (ref) => GoalTrackerSelectController(),
);

class GoalTrackerSelectController extends StateNotifier<GoalTrackerProvider?> {
  GoalTrackerSelectController() : super(null);

  bool isSelected(GoalTrackerProvider goalTracker) {
    return state == goalTracker;
  }

  void select(GoalTrackerProvider goalTracker) {
    state = isSelected(goalTracker) ? null : goalTracker;
  }
}
