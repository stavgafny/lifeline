import 'dart:convert';

import 'package:lifeline/src/utils/time_helper.dart';
import './upcoming_event_type.dart';

class UpcomingEventModel {
  final String name;
  final UpcomingEventType type;
  final DateTime datetime;
  final String details;
  UpcomingEventModel({
    required this.name,
    required this.type,
    required DateTime datetime,
    required this.details,
  }) : datetime = datetime.asFixed();

  /// Returns the number of remaining days
  int get daysRemain {
    return datetime.dateOnly().difference(DateTime.now().dateOnly()).inDays;
  }

  UpcomingEventModel copyWith({
    String? name,
    DateTime? datetime,
    UpcomingEventType? type,
    String? details,
  }) {
    return UpcomingEventModel(
      name: name ?? this.name,
      datetime: datetime?.asFixed() ?? this.datetime,
      type: type ?? this.type,
      details: details ?? this.details,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'datetime': datetime.millisecondsSinceEpoch,
      'type': type.toMap(),
      'details': details,
    };
  }

  factory UpcomingEventModel.fromMap(Map<String, dynamic> map) {
    return UpcomingEventModel(
      name: map['name'] as String,
      datetime: DateTime.fromMillisecondsSinceEpoch(map['datetime'] as int),
      type: UpcomingEventType.fromMap(map['type'] as String),
      details: map['details'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpcomingEventModel.fromJson(String source) =>
      UpcomingEventModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UpcomingEventModel(name: $name, datetime: $datetime, type: $type, details: $details)';
  }

  @override
  bool operator ==(covariant UpcomingEventModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.datetime == datetime &&
        other.type == type &&
        other.details == details;
  }

  @override
  int get hashCode {
    return name.hashCode ^ datetime.hashCode ^ type.hashCode ^ details.hashCode;
  }
}
