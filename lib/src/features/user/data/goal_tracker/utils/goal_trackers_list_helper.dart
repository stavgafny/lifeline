import '../models/goal_tracker_model.dart';

extension GoalTrackersListHelper on List<GoalTrackerModel> {
  List<GoalTrackerModel> thatArePlaying() {
    return where((goalTracker) => goalTracker.isPlaying).toList();
  }

  bool hasPlaying() {
    return thatArePlaying().isNotEmpty;
  }
}
