import 'dart:convert';

import 'package:lifeline/src/utils/time_helper.dart';
import './upcoming_event_type.dart';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'type': type.toMap(),
      'details': details,
    };
  }

  factory UpcomingEventModel.fromMap(Map<String, dynamic> map) {
    return UpcomingEventModel(
      name: map['name'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      type: UpcomingEventType.fromMap(map['type'] as String),
      details: map['details'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpcomingEventModel.fromJson(String source) =>
      UpcomingEventModel.fromMap(json.decode(source) as Map<String, dynamic>);

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
