import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/goal_tracker_model.dart';

typedef GoalTrackerProvider
    = StateNotifierProvider<GoalTrackerController, GoalTrackerModel>;

class GoalTrackerController extends StateNotifier<GoalTrackerModel> {
  Timer? _timer;
  GoalTrackerController(GoalTrackerModel model) : super(model) {
    if (model.isPlaying) {
      _initializeTickUpdates();
    }
  }

  void _play() {
    state = state.activated();
    _initializeTickUpdates();
  }

  void _stop() {
    _timer?.cancel();
    state = state.inactivated();
  }

  void _initializeTickUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.updated();
    });
  }

  void toggle() => state.isPlaying ? _stop() : _play();

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
