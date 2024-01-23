import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/models/deadline.dart';
import 'package:lifeline/src/models/playable_duration.dart';
import '../models/goal_tracker_model.dart';

//! Manually disposed by `GoalTrackersController`
typedef GoalTrackerProvider
    = StateNotifierProvider<GoalTrackerController, GoalTrackerModel>;

class GoalTrackerController extends StateNotifier<GoalTrackerModel> {
  Timer? _nextDeadlineTimer;

  GoalTrackerController(GoalTrackerModel model) : super(model) {
    _handleDeadline();
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
    _update(
      progress: state.progress.clear(
        keepPlay: keepPlay,
        fromDeadline: state.deadline,
      ),
    );
  }

  void _handleDeadline() {
    _nextDeadlineTimer?.cancel();

    if (state.deadline.reached) {
      _update(deadline: state.deadline.nextDeadline);

      if (state.deadline.isActive) {
        _resetProgress(keepPlay: true);
      }
    }

    _nextDeadlineTimer = Timer(state.deadline.remainingTime, _handleDeadline);
  }

  void _play() {
    _update(progress: state.progress.asPlaying());
  }

  void _stop() {
    _update(progress: state.progress.asPaused(trimSubseconds: true));
  }

  void toggle() => state.isPlaying ? _stop() : _play();

  void setName(String name) {
    if (name != state.name && name.isNotEmpty) {
      _update(name: name);
    }
  }

  void setDuration(Duration duration) {
    _update(duration: duration);
  }

  void setProgress(Duration duration) {
    _update(progress: state.progress.withNewDuration(duration: duration));
  }

  void setDeadline(Deadline deadline) {
    _update(deadline: deadline);
    _handleDeadline();
  }

  @override
  void dispose() {
    _nextDeadlineTimer?.cancel();
    super.dispose();
  }
}
