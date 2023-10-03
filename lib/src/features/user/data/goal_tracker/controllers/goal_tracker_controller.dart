import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifeline/src/models/playable_duration.dart';
import 'package:lifeline/src/services/global_time.dart';
import 'package:lifeline/src/utils/time_helper.dart';
import '../models/goal_tracker_model.dart';

//! Manually disposed by `GoalTrackersController`
typedef GoalTrackerProvider
    = StateNotifierProvider<GoalTrackerController, GoalTrackerModel>;

class GoalTrackerController extends StateNotifier<GoalTrackerModel> {
  Timer? _timer;
  StreamSubscription<void>? _deadlineTickSubscription;

  GoalTrackerController(GoalTrackerModel model) : super(model) {
    if (state.isPlaying) {
      _initializeTickUpdates();
    }
    _updateDeadline();
    _deadlineTickSubscription = GlobalTime.onEveryDeviceSecond.listen((_) {
      if (state.deadline.remainingTime.isNegative) {
        _resetProgress();
        _updateDeadline();
      } else {
        state = state.copyWith();
      }
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

  void _resetProgress() {
    if (state.isPlaying) {
      state = state.copyWith(
        progress: PlayableDuration.playing(timestamp: DateTime.now()),
      );
    } else {
      state = state.copyWith(progress: PlayableDuration.zero);
    }
  }

  void _updateDeadline() {
    state = state.copyWith(deadline: state.deadline.nextDeadline);
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
    _deadlineTickSubscription?.cancel();
    super.dispose();
  }
}
