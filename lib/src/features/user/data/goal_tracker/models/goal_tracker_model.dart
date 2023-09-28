import 'dart:convert';

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

  GoalTrackerModel copyWith({
    String? name,
    Duration? duration,
    Duration? progress,
    DateTime? playTimestamp,
  }) {
    return GoalTrackerModel(
      name: name ?? this.name,
      duration: duration ?? this.duration,
      progress: progress ?? this.progress,
      playTimestamp: playTimestamp ?? this.playTimestamp,
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
