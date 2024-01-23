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

  static String deadlineIterationDays(Deadline deadline) {
    final days = deadline.iterationDays;
    return "$days day${days != 1 ? 's' : ''}";
  }

  static String deadlineIterationTime(Deadline deadline) {
    final time = deadline.iterationTimeOfDay;
    return [
      time.hour.toString().padLeft(2, '0'),
      time.minute.toString().padLeft(2, '0'),
    ].join(":");
  }
}
