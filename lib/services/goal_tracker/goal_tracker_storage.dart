import 'dart:convert';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import '../../controllers/goal_tracker_controller.dart';
import './goal_tracker_foreground_task.dart';

Future<List<dynamic>> _loadJsonTrackers() async => jsonDecode(
    await FlutterForegroundTask.getData<String>(key: "goal_trackers") ?? "[]");

DateTime _getPlayedDate(Map<String, dynamic> jsonTracker) {
  return DateTime.fromMillisecondsSinceEpoch(int.parse(jsonTracker["playing"]))
      .add(Duration(milliseconds: int.parse(jsonTracker["progress"])));
}

class GoalTrackerStorage {
  static void save(List<GoalTrackerController> trackers) async {
    final jsonTrackers = [];
    for (final tracker in trackers) {
      jsonTrackers.add(tracker.toJson());
    }
    FlutterForegroundTask.saveData(
        key: "goal_trackers", value: jsonEncode(jsonTrackers));
  }

  static Future<List<GoalTrackerController>> load() async {
    // await Future.delayed(const Duration(seconds: 2));
    final List jsonTrackers = await _loadJsonTrackers();

    final trackers = <GoalTrackerController>[];
    if (jsonTrackers.isNotEmpty) {
      for (final jsonTracker in jsonTrackers) {
        trackers.add(GoalTrackerController.fromJson(jsonTracker));
      }
    }
    return trackers;
  }

  static Future<GoalTrackerNotification?> getNotificationInfo() async {
    // Returns the last played tracker and number of trackers to be displayed on the notification
    // If none are playing, returns null

    List jsonTrackers = (await _loadJsonTrackers())
        .where((jsonTracker) => jsonTracker["playing"] != "F")
        .toList();

    if (jsonTrackers.isNotEmpty) {
      int playingTrackers = jsonTrackers.length;
      final dynamic jsonTracker = jsonTrackers.reduce((a, b) {
        return _getPlayedDate(a).isAfter(_getPlayedDate(b)) ? a : b;
      });
      final tracker = GoalTrackerController.fromJson(jsonTracker);

      return GoalTrackerNotification(tracker, playingTrackers);
    }
    return null;
  }

  static Future<void> stopAllTrackers() async {
    List<GoalTrackerController> trackers = await load();
    for (var tracker in trackers) {
      tracker.togglePlaying(playing: false);
    }
    save(trackers);
  }
}
