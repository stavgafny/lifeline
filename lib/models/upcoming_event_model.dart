import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Path to all upcoming_events assets
const _assetsPath = "assets/upcoming_events/";

/// All upcoming event types by their name with an AssetImage value
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
  /// 10 years of range to set the date/days
  static const dateRange = 365 * 10;

  String name;
  DateTime date;
  UpcomingEventType type;

  /// Fixed time so smaller time units won't have an affect
  ///
  /// For example: using an unfixed time and then picking a new time which is on
  /// the same date will resolve in a time diffrences because the new
  /// picked time is fixed (has no hours, minutes, seconds and etc...)
  ///
  /// This results in a misbehavior with two times having the same dates and
  /// days remain while still being different
  UpcomingEventModel({
    required this.name,
    required DateTime date,
    required this.type,
  }) : date = DateTime(date.year, date.month, date.day); //! Fixed time (Y|M|D)

  /// Sets all values to given model
  void setValuesFromModel(UpcomingEventModel other) {
    name = other.name;
    date = other.date;
    type = other.type;
  }

  /// Copies and creates a new UpcomingEventModel instance from its values
  UpcomingEventModel copy() {
    return UpcomingEventModel(
      name: name,
      date: date,
      type: type,
    );
  }

  /// Checks if this current model values differs from given other model
  bool differsFrom(UpcomingEventModel other) {
    return name != other.name || date != other.date || type != other.type;
  }

  /// Returns stringified date in DD-MM-YYYY format
  String stringifiedDateDDMMYYYY() => "${date.day}/${date.month}/${date.year}";

  /// Returns stringified date in DD-MON-RR format
  String stringifiedDateDDMONRR() =>
      "${date.day} ${DateFormat('MMM').format(date)} ${date.year.toString().substring(2)}";

  /// Returns the date day of week name
  String dateDayOfWeek() => DateFormat('EEEE').format(date);

  /// Returns the number of remaining days
  int daysRemain() {
    // Get the difference bewteen date and current date
    final difference = date.difference(DateTime.now());

    // Round date days by checking if the difference without its days is still bigger then an empty duration
    final round =
        difference - Duration(days: difference.inDays) > const Duration();

    return difference.inDays + (round ? 1 : 0);
  }
}
