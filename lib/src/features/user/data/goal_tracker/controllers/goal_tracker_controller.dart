import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/utils/playable_duration.dart';
import 'package:lifeline/src/utils/time_helper.dart';
import '../models/goal_tracker_model.dart';

typedef GoalTrackerProvider
    = StateNotifierProvider<GoalTrackerController, GoalTrackerModel>;

class GoalTrackerController extends StateNotifier<GoalTrackerModel> {
  static int _uuid = 0;

  final int id = _uuid++;

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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
