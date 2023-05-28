import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  static const UpcomingEventType default_ = UpcomingEventType.event;

  const UpcomingEventType(this.value);
  final AssetImage value;
}

class UpcomingEventModel {
  /// 10 years of range to set the date/days
  static const int dateRange = 365 * 10;

  /// Normalize to a fixed date with the optional hours and minutes
  ///
  /// Default: hours=0, minutes=0
  static DateTime normalizeDate(DateTime date, {int hour = 0, int minute = 0}) {
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  /// Creates a new empty model with empty name, default type and current date
  /// with time set to midnight
  static UpcomingEventModel createEmpty() {
    return UpcomingEventModel(
      name: "",
      date: normalizeDate(DateTime.now()),
      type: UpcomingEventType.default_,
      details: "",
    );
  }

  String name;
  DateTime date;
  UpcomingEventType type;
  String details;

  UpcomingEventModel({
    required this.name,
    required DateTime date,
    required this.type,
    this.details = "",
  }) : date = normalizeDate(
          date,
          hour: date.hour,
          minute: date.minute,
        ); //! Normalized date time (Y|M|D|h|m)

  /// Sets all values to given model
  void setValuesFromModel(UpcomingEventModel other) {
    name = other.name.trim();
    date = other.date;
    type = other.type;
    details = other.details;
  }

  /// Copies and creates a new UpcomingEventModel instance from its values
  UpcomingEventModel copy() {
    return UpcomingEventModel(
      name: name,
      date: date,
      type: type,
      details: details,
    );
  }

  /// Checks if this current model values differs from given other model
  bool differsFrom(UpcomingEventModel other) {
    return name.trim() != other.name.trim() ||
        date != other.date ||
        type != other.type ||
        details != other.details;
  }

  /// Returns stringified date in DD-MM-YYYY format
  String stringifiedDateDDMMYYYY() => "${date.day}/${date.month}/${date.year}";

  /// Returns stringified date in DD-MON-RR format
  String stringifiedDateDDMONRR() =>
      "${date.day} ${DateFormat('MMM').format(date)} ${date.year.toString().substring(2)}";

  /// Returns the date day of week name
  String dateDayOfWeek() => DateFormat('EEEE').format(date);

  /// Returns the date time of day
  String timeOfDay() => DateFormat.Hm().format(date);

  /// Returns the number of remaining days
  int daysRemain() {
    final normalizedNow = normalizeDate(DateTime.now());
    final normalizedDate = normalizeDate(date);
    return normalizedDate.difference(normalizedNow).inDays;
  }

  /// Creates an [UpcomingEventModel] instance from `json` with default values
  /// for null properties
  static UpcomingEventModel fromJson(Map<String, dynamic> json) {
    final def = UpcomingEventModel.createEmpty();
    return UpcomingEventModel(
      name: json["name"] ?? def.name,
      date: DateTime.fromMillisecondsSinceEpoch(
          json["date"] ?? def.date.millisecondsSinceEpoch),
      type: UpcomingEventType.values.byName(json["type"] ?? def.type.name),
      details: json["details"] ?? def.details,
    );
  }

  /// Returns `json` model (date as unix time)
  Map<String, dynamic> toJson() => {
        "name": name,
        "date": date.millisecondsSinceEpoch,
        "type": type.name,
        "details": details,
      };
}
