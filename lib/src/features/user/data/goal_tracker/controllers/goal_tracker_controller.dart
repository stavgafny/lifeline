import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/utils/playable_duration.dart';
import 'package:lifeline/src/utils/time_helper.dart';
import '../models/goal_tracker_model.dart';

//! Manually disposed by `GoalTrackersController`
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
    state = state.copyWith(
      progress: PlayableDuration.playing(
        timestamp: DateTime.now().subtract(state.progress.current),
      ),
    );
    _initializeTickUpdates();
  }

  void _stop() {
    _timer?.cancel();
    state = state.copyWith(
      progress: PlayableDuration.paused(
        duration: state.progress.current.trimSubseconds(),
      ),
    );
  }

  void _initializeTickUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith();
    });
  }

  void toggle() => state.isPlaying ? _stop() : _play();

  void reset() => state = state.copyWith(progress: PlayableDuration.zero);

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}