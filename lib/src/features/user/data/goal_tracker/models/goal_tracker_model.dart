import 'dart:convert';

import 'package:lifeline/src/utils/time_helper.dart';

class GoalTrackerModel {
  final String name;
  final Duration duration;
  final Duration progress;
  final DateTime? playTimestamp;
  const GoalTrackerModel({
    required this.name,
    required this.duration,
    required this.progress,
    this.playTimestamp,
  });

  bool get isPlaying => playTimestamp != null;

  double get progressPrecentage {
    if (duration == const Duration()) return 0;
    return progress.inMilliseconds / duration.inMilliseconds;
  }

  String get playTimeInfo {
    return "${progress.format(secondary: true)} / ${duration.format(secondary: true)}";
  }

  GoalTrackerModel activated() {
    return nullableCopyWith(
        playTimestamp: () => DateTime.now().subtract(progress));
  }

  GoalTrackerModel updated() {
    final now = DateTime.now();
    final addedProgress = now.difference(playTimestamp ?? now);
    return nullableCopyWith(progress: addedProgress);
  }

  GoalTrackerModel inactivated() {
    final current = updated();
    return current.nullableCopyWith(
      progress: current.progress.trimSubseconds(),
      playTimestamp: () => null,
    );
  }

  GoalTrackerModel nullableCopyWith({
    String? name,
    Duration? duration,
    Duration? progress,
    DateTime? Function()? playTimestamp,
  }) {
    return GoalTrackerModel(
      name: name ?? this.name,
      duration: duration ?? this.duration,
      progress: progress ?? this.progress,
      playTimestamp:
          playTimestamp != null ? playTimestamp() : this.playTimestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'duration': duration.inMilliseconds,
      'progress': progress.inMilliseconds,
      'playTimestamp': playTimestamp?.millisecondsSinceEpoch,
    };
  }

  factory GoalTrackerModel.fromMap(Map<String, dynamic> map) {
    return GoalTrackerModel(
      name: map['name'] as String,
      duration: Duration(milliseconds: map['duration'] as int),
      progress: Duration(milliseconds: map['progress'] as int),
      playTimestamp: map['playTimestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['playTimestamp'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GoalTrackerModel.fromJson(String source) =>
      GoalTrackerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GoalTrackerModel(name: $name, duration: $duration, progress: $progress, playTimestamp: $playTimestamp)';
  }

  @override
  bool operator ==(covariant GoalTrackerModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.duration == duration &&
        other.progress == progress &&
        other.playTimestamp == playTimestamp;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        duration.hashCode ^
        progress.hashCode ^
        playTimestamp.hashCode;
  }
}
