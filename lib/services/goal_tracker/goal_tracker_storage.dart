import 'dart:convert';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import '../../controllers/goal_tracker_controller.dart';
import './goal_tracker_foreground_task.dart';

// returns list of json goal trackers
Future<List<dynamic>> _getJsonTrackers() async => jsonDecode(
    await FlutterForegroundTask.getData<String>(key: "goal_trackers") ?? "[]");

// returns timestamp when json tracker last played
DateTime _getPlayedDate(Map<String, dynamic> jsonTracker) {
  return DateTime.fromMillisecondsSinceEpoch(int.parse(jsonTracker["playing"]))
      .add(Duration(milliseconds: int.parse(jsonTracker["progress"])));
}

class GoalTrackerStorage {
  static List<GoalTrackerController>? storedTrackers;

  static Future<void> _save(List<GoalTrackerController> trackers) async {
    // Stores given trackers
    final jsonTrackers = [];
    for (final tracker in trackers) {
      jsonTrackers.add(tracker.toJson());
    }
    await FlutterForegroundTask.saveData(
        key: "goal_trackers", value: jsonEncode(jsonTrackers));
  }

  static Future<void> saveStoredTrackers() async {
    // Save stored trackers only if has been assigned
    if (storedTrackers != null) {
      await _save(storedTrackers!);
    }
  }

  static Future<List<GoalTrackerController>> fetch() async {
    // Returns future that contains list of loaded goal trackers
    final List jsonTrackers = await _getJsonTrackers();
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

    List jsonTrackers = (await _getJsonTrackers())
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
    List<GoalTrackerController> trackers = await fetch();
    for (var tracker in trackers) {
      tracker.togglePlaying(playing: false);
    }
    _save(trackers);
  }
}
