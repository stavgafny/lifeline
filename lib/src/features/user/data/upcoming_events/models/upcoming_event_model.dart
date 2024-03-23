import 'package:flutter/material.dart';
import 'package:lifeline/src/utils/time_helper.dart';

part './upcoming_event_type.dart';

class UpcomingEventModel {
  final String name;
  final UpcomingEventType type;
  final DateTime dateTime;
  final String details;

  UpcomingEventModel({
    required this.name,
    required this.type,
    required DateTime dateTime,
    required this.details,
  }) : dateTime = dateTime.asFixed();

  UpcomingEventModel.empty()
      : name = "",
        type = UpcomingEventType.defaultType,
        dateTime = DateTime.now().dateOnly(),
        details = "";

  /// Returns the number of remaining days
  int get daysRemain {
    return dateTime.dateOnly().difference(DateTime.now().dateOnly()).inDays;
  }

  UpcomingEventModel copyWith({
    String? name,
    DateTime? dateTime,
    UpcomingEventType? type,
    String? details,
  }) {
    return UpcomingEventModel(
      name: name ?? this.name,
      dateTime: dateTime?.asFixed() ?? this.dateTime,
      type: type ?? this.type,
      details: details ?? this.details,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'type': type.toJson(),
      'details': details,
    };
  }

  factory UpcomingEventModel.fromJson(dynamic map) {
    return UpcomingEventModel(
      name: map['name'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      type: UpcomingEventType.fromJson(map['type'] as String),
      details: map['details'] as String,
    );
  }

  @override
  String toString() {
    return 'UpcomingEventModel(name: $name, dateTime: $dateTime, type: $type, details: $details)';
  }

  @override
  bool operator ==(covariant UpcomingEventModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.dateTime == dateTime &&
        other.type == type &&
        other.details == details;
  }

  @override
  int get hashCode {
    return name.hashCode ^ dateTime.hashCode ^ type.hashCode ^ details.hashCode;
  }
}
