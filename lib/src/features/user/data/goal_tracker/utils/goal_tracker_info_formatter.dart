import 'package:lifeline/src/models/deadline.dart';
import 'package:lifeline/src/utils/time_helper.dart';
import '../models/goal_tracker_model.dart';

class GoalTrackerInfoFormatter {
  static String progressPrecentage(GoalTrackerModel model) {
    return "${(model.progressPrecentage * 100).floor()}%";
  }

  static String playtime(GoalTrackerModel model) {
    final progress = model.progress.current.format(DurationFormatType.extended);
    final duration = model.duration.format(DurationFormatType.extended);

    return "$progress / $duration";
  }

  static String deadlineRemainingTime(Deadline deadline, bool extended) {
    return deadline.remainingTime.format(
      extended ? DurationFormatType.extended : DurationFormatType.compact,
    );
  }
}
