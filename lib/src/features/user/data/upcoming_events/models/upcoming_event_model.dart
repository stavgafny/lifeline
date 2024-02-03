import 'dart:convert';

import 'package:lifeline/src/utils/time_helper.dart';
import './upcoming_event_type.dart';

class UpcomingEventModel {
  final String name;
  final UpcomingEventType type;
  final DateTime date;
  final String details;
  UpcomingEventModel({
    required this.name,
    required this.type,
    required DateTime date,
    required this.details,
  }) : date = date.asFixed();

  UpcomingEventModel copyWith({
    String? name,
    DateTime? date,
    UpcomingEventType? type,
    String? details,
  }) {
    return UpcomingEventModel(
      name: name ?? this.name,
      date: date?.asFixed() ?? this.date,
      type: type ?? this.type,
      details: details ?? this.details,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'date': date.millisecondsSinceEpoch,
      'type': type.toMap(),
      'details': details,
    };
  }

  factory UpcomingEventModel.fromMap(Map<String, dynamic> map) {
    return UpcomingEventModel(
      name: map['name'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      type: UpcomingEventType.fromMap(map['type'] as String),
      details: map['details'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpcomingEventModel.fromJson(String source) =>
      UpcomingEventModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UpcomingEventModel(name: $name, date: $date, type: $type, details: $details)';
  }

  @override
  bool operator ==(covariant UpcomingEventModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.date == date &&
        other.type == type &&
        other.details == details;
  }

  @override
  int get hashCode {
    return name.hashCode ^ date.hashCode ^ type.hashCode ^ details.hashCode;
  }
}
