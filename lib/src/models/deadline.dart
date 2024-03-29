import 'dart:convert';

import 'package:flutter/material.dart';

class Deadline {
  static DateTime _getNextDeadlineDate(int days, TimeOfDay time) {
    final now = DateTime.now();
    final date = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    if (now.isBefore(date)) {
      days--;
    }
    return date.add(Duration(days: days));
  }

  final DateTime date;
  final int iterationDays;
  final TimeOfDay iterationTimeOfDay;
  final bool isActive;
  const Deadline({
    required this.date,
    required this.iterationDays,
    required this.iterationTimeOfDay,
    required this.isActive,
  });

  Deadline.create({
    this.iterationDays = 1,
    this.iterationTimeOfDay = const TimeOfDay(hour: 0, minute: 0),
    this.isActive = true,
  }) : date = Deadline._getNextDeadlineDate(iterationDays, iterationTimeOfDay);

  Duration get remainingTime => date.difference(DateTime.now());

  bool get reached => remainingTime <= Duration.zero;

  Deadline get nextDeadline => copyWith(
        date: Deadline._getNextDeadlineDate(iterationDays, iterationTimeOfDay),
      );

  Duration get durationBetweenDeadlines => Duration(days: iterationDays);

  Deadline get previousDeadline {
    final deadline = nextDeadline;
    return deadline.copyWith(
      date: deadline.date.subtract(Duration(days: deadline.iterationDays)),
    );
  }

  Deadline reCreateWith({
    DateTime? date,
    int? iterationDays,
    TimeOfDay? iterationTimeOfDay,
    bool? isActive,
  }) {
    return Deadline.create(
      iterationDays: iterationDays ?? this.iterationDays,
      iterationTimeOfDay: iterationTimeOfDay ?? this.iterationTimeOfDay,
      isActive: isActive ?? this.isActive,
    );
  }

  Deadline copyWith({
    DateTime? date,
    int? iterationDays,
    TimeOfDay? iterationTimeOfDay,
    bool? isActive,
  }) {
    return Deadline(
      date: date ?? this.date,
      iterationDays: iterationDays ?? this.iterationDays,
      iterationTimeOfDay: iterationTimeOfDay ?? this.iterationTimeOfDay,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'iterationDays': iterationDays,
      'iterationTimeOfDay': _TimeOfDayHelper.toMap(iterationTimeOfDay),
      'isActive': isActive,
    };
  }

  factory Deadline.fromMap(Map<String, dynamic> map) {
    return Deadline(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      iterationDays: map['iterationDays'] as int,
      iterationTimeOfDay: _TimeOfDayHelper.fromMap(
        map['iterationTimeOfDay'] as String,
      ),
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Deadline.fromJson(String source) =>
      Deadline.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Deadline(date: $date, iterationDays: $iterationDays, iterationTimeOfDay: $iterationTimeOfDay, isActive: $isActive)';
  }

  @override
  bool operator ==(covariant Deadline other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.iterationDays == iterationDays &&
        other.iterationTimeOfDay == iterationTimeOfDay &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        iterationDays.hashCode ^
        iterationTimeOfDay.hashCode ^
        isActive.hashCode;
  }
}

/// Time of day serialization helper class
class _TimeOfDayHelper {
  static String toMap(TimeOfDay timeOfDay) {
    return "${timeOfDay.hour}:${timeOfDay.minute}";
  }

  static TimeOfDay fromMap(String mappedTimeOfDay) {
    final time = mappedTimeOfDay.split(':');
    return TimeOfDay(
      hour: int.parse(time[0]),
      minute: int.parse(time[1]),
    );
  }
}
