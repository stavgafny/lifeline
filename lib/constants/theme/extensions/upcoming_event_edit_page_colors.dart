import 'package:flutter/material.dart';

@immutable
class UpcomingEventEditPageColors
    extends ThemeExtension<UpcomingEventEditPageColors> {
  final Color? date;
  final Color? days;
  final Color? time;

  const UpcomingEventEditPageColors({
    required this.date,
    required this.days,
    required this.time,
  });

  @override
  UpcomingEventEditPageColors copyWith(
      {Color? date, Color? days, Color? time}) {
    return UpcomingEventEditPageColors(
      date: date ?? this.date,
      days: days ?? this.days,
      time: time ?? this.time,
    );
  }

  @override
  UpcomingEventEditPageColors lerp(
      UpcomingEventEditPageColors? other, double t) {
    if (other is! UpcomingEventEditPageColors) return this;

    return UpcomingEventEditPageColors(
      date: Color.lerp(date, other.date, t),
      days: Color.lerp(days, other.days, t),
      time: Color.lerp(time, other.time, t),
    );
  }
}
