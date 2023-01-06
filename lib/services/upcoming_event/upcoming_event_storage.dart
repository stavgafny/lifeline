import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/upcoming_event_model.dart';

/// Returns JSON encoded string of upcoming events list
/// converts list of upcoming event models to stringifed json objects
String _encodeUpcomingEvents(List<UpcomingEventModel> upcomingEvents) {
  final jsonUpcomingEvents = [];
  for (final upcomingEvent in upcomingEvents) {
    jsonUpcomingEvents.add(upcomingEvent.toJson());
  }
  return jsonEncode(jsonUpcomingEvents);
}

/// Returns parsed upcoming events list object from given json
/// converts stringifed list of json upcoming event models to list of objects
List<UpcomingEventModel> _decodeUpcomingEvents(String jsonUpcomingEvents) {
  final upcomingEvents = <UpcomingEventModel>[];
  for (final jsonUpcomingEventModel in jsonDecode(jsonUpcomingEvents)) {
    upcomingEvents.add(UpcomingEventModel.fromJson(jsonUpcomingEventModel));
  }
  return upcomingEvents;
}

class UpcomingEventStorage {
  /// SharedPreferences instance for predictable local data save/fetch
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  /// Checks if has been modified scince last fetch (null if not fetched)
  static String? _jsonLastFetch;

  /// Returns fetched list of upcoming events as json string
  static Future<String> _getJsonUpcomingEvents() async {
    final prefs = await _prefs;
    return prefs.getString("upcoming_events") ?? "[]";
  }

  /// Saves given json upcoming events list
  static Future<void> _save(String jsonUpcomingEvents) async {
    final prefs = await _prefs;
    await prefs.setString("upcoming_events", jsonUpcomingEvents);
  }

  /// Saves given upcoming events if had fetched before and modified since then
  static Future<void> saveUpcomingEvents(
      List<UpcomingEventModel> upcomingEvents) async {
    if (_jsonLastFetch == null) return;

    final jsonUpcomingEvents = _encodeUpcomingEvents(upcomingEvents);
    // If the jsons differ from each other then it has been modified
    if (jsonUpcomingEvents != _jsonLastFetch) {
      // Sets "_jsonLastFetch" to the new saved json
      _jsonLastFetch = jsonUpcomingEvents;
      await _save(jsonUpcomingEvents);
    }
  }

  /// Fetches upcoming events list from local data
  /// gets json and sets to "_jsonLastFetch"
  /// Parses and returns a future of json decoded upcoming events list
  static Future<List<UpcomingEventModel>> fetch() async {
    _jsonLastFetch = await _getJsonUpcomingEvents();
    return _decodeUpcomingEvents(_jsonLastFetch!);
  }
}
