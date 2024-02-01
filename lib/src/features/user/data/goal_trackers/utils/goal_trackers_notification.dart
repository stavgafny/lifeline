import '../models/goal_tracker_model.dart';
import './goal_trackers_list_helper.dart';
import './goal_tracker_info_formatter.dart';

class NoPlayingGoalTrackersException implements Exception {}

class GoalTrackersNotification {
  final GoalTrackerModel goalTracker;
  final int playingNumber;

  GoalTrackersNotification._({
    required this.goalTracker,
    required this.playingNumber,
  });

  factory GoalTrackersNotification.createFromGoalTrackers({
    required List<GoalTrackerModel> goalTrackers,
  }) {
    final playingGoalTrackers = goalTrackers.thatArePlaying();
    if (playingGoalTrackers.isEmpty) {
      throw NoPlayingGoalTrackersException();
    }

    return GoalTrackersNotification._(
      goalTracker: playingGoalTrackers.first,
      playingNumber: playingGoalTrackers.length,
    );
  }

  String get title {
    return goalTracker.name;
  }

  String get body {
    final otherTrackers = playingNumber > 1
        ? "\r\n(+${playingNumber - 1} Tracker${playingNumber - 1 > 1 ? 's' : ''})"
        : "";

    return "${GoalTrackerInfoFormatter.playtime(goalTracker)}"
        "${' ' * 4}"
        "(${GoalTrackerInfoFormatter.progressPrecentage(goalTracker)})"
        "$otherTrackers";
  }
}
