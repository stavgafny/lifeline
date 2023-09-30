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
  GoalTrackerController(GoalTrackerModel model) : super(model);

  void _play() {
    state = state.copyWith(playTimestamp: DateTime.now());
  }

  void _stop() {
    final addedProgress = DateTime.now().difference(state.playTimestamp!);
    state = GoalTrackerModel.pure().copyWith(
      name: state.name,
      duration: state.duration,
      progress: state.progress + addedProgress,
    );
  }

  void toggle() => state.isPlaying ? _stop() : _play();
}
