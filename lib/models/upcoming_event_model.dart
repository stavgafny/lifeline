import 'package:flutter/material.dart';

const _assetsPath = "assets/upcoming_events/";

enum UpcomingEventType {
  celebration(AssetImage("$_assetsPath" "celebration.png")),
  vacation(AssetImage("$_assetsPath" "vacation.png")),
  education(AssetImage("$_assetsPath" "education.png")),
  movie(AssetImage("$_assetsPath" "movie.png")),
  grocery(AssetImage("$_assetsPath" "grocery.png")),
  shopping(AssetImage("$_assetsPath" "shopping.png")),
  trip(AssetImage("$_assetsPath" "trip.png")),
  workout(AssetImage("$_assetsPath" "workout.png")),
  yoga(AssetImage("$_assetsPath" "yoga.png"));

  const UpcomingEventType(this.value);
  final AssetImage value;
}

class UpcomingEventModel {
  final String name;
  final DateTime date;
  final UpcomingEventType type;

  const UpcomingEventModel({
    required this.name,
    required this.date,
    required this.type,
  });
}
