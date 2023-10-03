import 'dart:convert';

import 'package:lifeline/src/models/deadline.dart';
import 'package:lifeline/src/models/playable_duration.dart';
import 'package:lifeline/src/utils/time_helper.dart';

class GoalTrackerModel {
  final String name;
  final Duration duration;
  final PlayableDuration progress;
  final Deadline deadline;

  const GoalTrackerModel({
    required this.name,
    required this.duration,
    required this.progress,
    required this.deadline,
  });

  bool get isPlaying => progress.isPlaying;

  double get progressPrecentage {
    if (duration == Duration.zero) {
      return (progress.current == Duration.zero) ? 0 : 1;
    }
    return progress.current.inMilliseconds / duration.inMilliseconds;
  }

  String get formattedProgressPrecentage {
    return "${(progressPrecentage * 100).floor()}%";
  }

  String get playTimeInfo {
    return "${progress.current.format(secondary: true)} / ${duration.format(secondary: true)}";
  }

  String get deadlineRemainingTimeInfo {
    return deadline.remainingTime.format();
  }

  GoalTrackerModel copyWith({
    String? name,
    Duration? duration,
    PlayableDuration? progress,
    Deadline? deadline,
  }) {
    return GoalTrackerModel(
      name: name ?? this.name,
      duration: duration ?? this.duration,
      progress: progress ?? this.progress,
      deadline: deadline ?? this.deadline,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'duration': duration.inMilliseconds,
      'progress': progress.toMap(),
      'deadline': deadline.toMap(),
    };
  }

  factory GoalTrackerModel.fromMap(Map<String, dynamic> map) {
    return GoalTrackerModel(
      name: map['name'] as String,
      duration: Duration(milliseconds: map['duration'] as int),
      progress: PlayableDuration.fromMap(
        map['progress'] as Map<String, dynamic>,
      ),
      deadline: Deadline.fromMap(
        map['deadline'] as Map<String, dynamic>,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory GoalTrackerModel.fromJson(String source) =>
      GoalTrackerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GoalTrackerModel(name: $name, duration: $duration, progress: $progress, deadline: $deadline)';

  @override
  bool operator ==(covariant GoalTrackerModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.duration == duration &&
        other.progress == progress &&
        other.deadline == deadline;
  }

  @override
  int get hashCode =>
      name.hashCode ^ duration.hashCode ^ progress.hashCode ^ deadline.hashCode;
}
