import 'dart:convert';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import '../../controllers/goal_tracker_controller.dart';
import './goal_tracker_foreground_task.dart';

/// Returns goal trackers list as json
String _encodeGoalTrackers(List<GoalTrackerController> goalTrackers) {
  final jsonGoalTrackers = [];
  for (final goalTracker in goalTrackers) {
    jsonGoalTrackers.add(goalTracker.toJson());
  }
  return jsonEncode(jsonGoalTrackers);
}

/// Returns parsed goal tracker json
List<GoalTrackerController> _decodeGoalTrackers(String jsonGoalTrackers) {
  final goalTrackers = <GoalTrackerController>[];
  for (final jsonUpcomingEventModel in jsonDecode(jsonGoalTrackers)) {
    goalTrackers.add(GoalTrackerController.fromJson(jsonUpcomingEventModel));
  }
  return goalTrackers;
}

/// Returns json list of goal trackers
Future<String> _getJsonGoalTrackers() async =>
    await FlutterForegroundTask.getData<String>(key: "goal_trackers") ?? "[]";

// Returns datetime when json tracker was played
DateTime _getPlayedDateTime(Map<String, dynamic> jsonGoalTracker) =>
    DateTime.fromMillisecondsSinceEpoch(jsonGoalTracker["playing"]);

class GoalTrackerStorage {
  /// Goal trackers to be later stored, gets assigned privately by fetch method
  static List<GoalTrackerController> _storedGoalTrackers = [];

  /// Holds the last fetched json to later check if modified
  static String? _lastFetchedJson;

  /// Saves given json goal trackers list and updates [_lastFetchedJson] to it
  static Future<void> _save(String jsonGoalTrackers) async {
    _lastFetchedJson = jsonGoalTrackers;
    await FlutterForegroundTask.saveData(
      key: "goal_trackers",
      value: jsonGoalTrackers,
    );
  }

  /// Saves stored goal trackers if had previously fetched and modified since
  static Future<void> saveStoredGoalTrackers() async {
    if (_lastFetchedJson == null) return; //! If not previously fetched
    final jsonGoalTrackers = _encodeGoalTrackers(_storedGoalTrackers);
    if (jsonGoalTrackers == _lastFetchedJson) return; //! If not modified since
    await _save(jsonGoalTrackers);
  }

  /// Fetches goal trackers list json and sets to [_lastFetchedJson]
  ///
  /// parses fetched json and sets to [_storedGoalTrackers]
  ///
  /// Returns [_storedGoalTrackers] list reference to be assigned
  static Future<List<GoalTrackerController>> fetch() async {
    _lastFetchedJson = await _getJsonGoalTrackers();
    _storedGoalTrackers = _decodeGoalTrackers(_lastFetchedJson!);
    return _storedGoalTrackers;
  }

  static Future<GoalTrackerNotification?> getNotificationInfo() async {
    final List jsonGoalTrackersList = jsonDecode(await _getJsonGoalTrackers());

    final List playingJsonGoalTrackers = jsonGoalTrackersList
        .where((jsonGoalTracker) => jsonGoalTracker["playing"] != -1)
        .toList();

    if (playingJsonGoalTrackers.isEmpty) return null;

    final playingGoalTrackersNumber = playingJsonGoalTrackers.length;

    // Getting the latest played one out of all of them
    final dynamic jsonGoalTracker = playingJsonGoalTrackers.reduce(
        (a, b) => _getPlayedDateTime(a).isAfter(_getPlayedDateTime(b)) ? a : b);

    final goalTracker = GoalTrackerController.fromJson(jsonGoalTracker);

    return GoalTrackerNotification(goalTracker, playingGoalTrackersNumber);
  }

  /// Stops all currently playing goal trackers and re-saves it
  static Future<void> stopAllTrackers() async {
    List<GoalTrackerController> goalTrackers = await fetch();
    for (final tracker in goalTrackers) {
      tracker.togglePlaying(playing: false);
    }
    return await saveStoredGoalTrackers();
  }
}
