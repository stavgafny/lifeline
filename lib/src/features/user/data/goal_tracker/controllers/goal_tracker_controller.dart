import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/models/deadline.dart';
import 'package:lifeline/src/models/playable_duration.dart';
import 'package:lifeline/src/utils/time_helper.dart';
import '../models/goal_tracker_model.dart';

//! Manually disposed by `GoalTrackersController`
typedef GoalTrackerProvider
    = StateNotifierProvider<GoalTrackerController, GoalTrackerModel>;

class GoalTrackerController extends StateNotifier<GoalTrackerModel> {
  Timer? _timer;
  Timer? _nextDeadlineTimer;

  GoalTrackerController(GoalTrackerModel model) : super(model) {
    _handleDeadline();
    if (state.isPlaying) {
      _initializeTickUpdates();
    }
  }

  void _update({
    String? name,
    Duration? duration,
    PlayableDuration? progress,
    Deadline? deadline,
  }) {
    state = state.copyWith(
      name: name,
      duration: duration,
      progress: progress,
      deadline: deadline,
    );
  }

  void _resetProgress({required bool keepPlay}) {
    _update(progress: state.progress.clear(keepPlay: keepPlay));
  }

  void _handleDeadline() {
    _nextDeadlineTimer?.cancel();
    final nextDeadline = state.deadline.nextDeadline;
    if (nextDeadline != state.deadline) {
      _update(deadline: nextDeadline);
    }

    _nextDeadlineTimer = Timer(nextDeadline.remainingTime, () {
      if (state.deadline.reached) {
        _resetProgress(keepPlay: true);
      }
      Future.delayed(Duration.zero, _handleDeadline);
    });
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

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _nextDeadlineTimer?.cancel();
    super.dispose();
  }
}
