import 'package:lifeline/src/models/deadline.dart';
import 'package:lifeline/src/utils/time_helper.dart';
import '../models/goal_tracker_model.dart';

class GoalTrackerInfoFormatter {
  static String progressPrecentage(GoalTrackerModel model) {
    return "${(model.progressPrecentage * 100).floor()}%";
  }

  static String playtime(GoalTrackerModel model) {
    return "${model.progress.current.format(secondary: true)} / ${model.duration.format(secondary: true)}";
  }

  static String deadlineRemainingTime(Deadline deadline, bool secondary) {
    return deadline.remainingTime.format(secondary: secondary);
  }
}
