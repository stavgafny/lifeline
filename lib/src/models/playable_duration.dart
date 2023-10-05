import 'dart:convert';

import 'package:lifeline/src/utils/time_helper.dart';
import './deadline.dart';

class PlayableDuration {
  final bool isPlaying;
  final Duration? _duration;
  final DateTime? _timestamp;

  static PlayableDuration get zero =>
      const PlayableDuration.paused(duration: Duration.zero);

  const PlayableDuration.playing({required DateTime timestamp})
      : _duration = null,
        _timestamp = timestamp,
        isPlaying = true;

  const PlayableDuration.paused({required Duration duration})
      : _duration = duration,
        _timestamp = null,
        isPlaying = false;

  PlayableDuration asPlaying() {
    return PlayableDuration.playing(
      timestamp: DateTime.now().subtract(current),
    );
  }

  PlayableDuration asPaused({bool trimSubseconds = false}) {
    return PlayableDuration.paused(
      duration: trimSubseconds ? current.trimSubseconds() : current,
    );
  }

  PlayableDuration clear({required bool keepPlay, Deadline? fromDeadline}) {
    if (isPlaying && keepPlay) {
      final now = DateTime.now();
      DateTime preservedProgress = now;

      if (fromDeadline != null) {
        final diff = now.difference(fromDeadline.previousDeadline.date);
        final clamped = diff.modulo(fromDeadline.durationBetweenDeadlines);
        preservedProgress = now.subtract(clamped);
      }

      return PlayableDuration.playing(timestamp: preservedProgress);
    }
    return PlayableDuration.zero;
  }

  Duration get current {
    if (!isPlaying) return _duration ?? const Duration();
    final now = DateTime.now();
    return now.difference(_timestamp ?? now);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isPlaying': isPlaying,
      'value': isPlaying
          ? _timestamp!.millisecondsSinceEpoch
          : _duration!.inMilliseconds,
    };
  }

  factory PlayableDuration.fromMap(Map<String, dynamic> map) {
    final isPlaying = map['isPlaying'] as bool;
    final valueMil = map['value'] as int;
    if (isPlaying) {
      return PlayableDuration.playing(
        timestamp: DateTime.fromMillisecondsSinceEpoch(valueMil),
      );
    }
    return PlayableDuration.paused(duration: Duration(milliseconds: valueMil));
  }

  String toJson() => json.encode(toMap());

  factory PlayableDuration.fromJson(String source) =>
      PlayableDuration.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PlayableDuration(isPlaying $isPlaying, current: $current)';
  }

  @override
  bool operator ==(covariant PlayableDuration other) {
    if (identical(this, other)) return true;

    return other.isPlaying == isPlaying &&
        other._duration == _duration &&
        other._timestamp == _timestamp;
  }

  @override
  int get hashCode =>
      isPlaying.hashCode ^ _duration.hashCode ^ _timestamp.hashCode;
}
