import 'package:flutter/material.dart';

// Path to all upcoming_events assets
const _assetsPath = "assets/upcoming_events/";

/// All upcoming event types by their name with an AssetImage value
enum UpcomingEventType {
  event(AssetImage("$_assetsPath" "event.png")),
  celebration(AssetImage("$_assetsPath" "celebration.png")),
  birthday(AssetImage("$_assetsPath" "birthday.png")),
  wedding(AssetImage("$_assetsPath" "wedding.png")),
  vacation(AssetImage("$_assetsPath" "vacation.png")),
  trip(AssetImage("$_assetsPath" "trip.png")),
  movie(AssetImage("$_assetsPath" "movie.png")),
  shopping(AssetImage("$_assetsPath" "shopping.png")),
  workout(AssetImage("$_assetsPath" "workout.png")),
  yoga(AssetImage("$_assetsPath" "yoga.png")),
  education(AssetImage("$_assetsPath" "education.png")),
  groceries(AssetImage("$_assetsPath" "groceries.png"));

  static const UpcomingEventType defaultType = UpcomingEventType.event;

  const UpcomingEventType(this.value);
  final AssetImage value;

  String toMap() {
    return name;
  }

  factory UpcomingEventType.fromMap(String mappedType) {
    try {
      return UpcomingEventType.values.byName(mappedType);
    } catch (_) {
      return defaultType;
    }
  }
}
