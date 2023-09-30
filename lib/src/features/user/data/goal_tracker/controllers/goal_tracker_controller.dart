import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/goal_tracker_model.dart';

final goalTrackerProvider =
    StateNotifierProvider<GoalTrackerController, GoalTrackerModel>(
  (ref) => GoalTrackerController(
    const GoalTrackerModel(
      name: 'Goal Tracker [RC]',
      duration: Duration(seconds: 50),
      progress: Duration(),
      playTimestamp: null,
    ),
  ),
);

class GoalTrackerController extends StateNotifier<GoalTrackerModel> {
  Timer? _timer;
  GoalTrackerController(GoalTrackerModel model) : super(model);

  void _play() {
    state = state.activated();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.updated();
    });
  }

  void _stop() {
    _timer?.cancel();
    state = state.inactivated();
  }

  void toggle() => state.isPlaying ? _stop() : _play();
}
