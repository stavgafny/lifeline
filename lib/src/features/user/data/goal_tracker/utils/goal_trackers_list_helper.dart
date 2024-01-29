import '../models/goal_tracker_model.dart';

extension GoalTrackersListHelper on List<GoalTrackerModel> {
  bool hasPlaying() => thatArePlaying().isNotEmpty;

  List<GoalTrackerModel> thatArePlaying() {
    return where((goalTracker) => goalTracker.isPlaying).toList();
  }

  void stopAll() {
    for (int i = 0; i < length; i++) {
      final goalTracker = this[i];
      this[i] = goalTracker.copyWith(
        progress: goalTracker.progress.asPaused(trimSubseconds: true),
      );
    }
  }
}
