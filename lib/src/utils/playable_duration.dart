import 'dart:convert';

class PlayableDuration {
  final bool isPlaying;
  final Duration? _duration;
  final DateTime? _timestamp;

  const PlayableDuration.playing({required DateTime timestamp})
      : _duration = null,
        _timestamp = timestamp,
        isPlaying = true;

  const PlayableDuration.paused({required Duration duration})
      : _duration = duration,
        _timestamp = null,
        isPlaying = false;

  static PlayableDuration get zero =>
      const PlayableDuration.paused(duration: Duration.zero);

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
}
