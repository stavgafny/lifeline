import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/upcoming_event_model.dart';

class UpcomingEventStorage {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static List<UpcomingEventModel>? storedUpcomingEvents;

  // returns list of json upcoming events
  static Future<List<dynamic>> _getJsonUpcomingEvents() async {
    final prefs = await _prefs;
    return await jsonDecode(prefs.getString("upcoming_events") ?? "[]");
  }

  static Future<void> _save(List<UpcomingEventModel> upcomingEvents) async {
    // Stores given upcomingEvents
    final jsonUpcomingEvents = [];
    for (final upcomingEvent in upcomingEvents) {
      jsonUpcomingEvents.add(upcomingEvent.toJson());
    }
    final prefs = await _prefs;
    await prefs.setString("upcoming_events", jsonEncode(jsonUpcomingEvents));
  }

  static Future<void> saveStoredUpcomingEvents() async {
    // Save stored upcoming events only if has been assigned
    if (storedUpcomingEvents != null) {
      await _save(storedUpcomingEvents!);
    }
  }

  static Future<List<UpcomingEventModel>> fetch() async {
    final List jsonUpcomingEvents = await _getJsonUpcomingEvents();
    final upcomingEvents = <UpcomingEventModel>[];

    if (jsonUpcomingEvents.isNotEmpty) {
      for (final jsonUpcomingEvent in jsonUpcomingEvents) {
        upcomingEvents.add(UpcomingEventModel.fromJson(jsonUpcomingEvent));
      }
    }
    return upcomingEvents;
  }
}
