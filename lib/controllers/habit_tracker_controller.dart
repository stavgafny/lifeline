import 'dart:async';
import 'package:get/get.dart';

enum DeadlineRoutine { daily, weekly, monthly }

class Deadline {
  static DateTime getNextDate(DeadlineRoutine routine) {
    final current = DateTime.now();
    switch (routine) {
      case DeadlineRoutine.daily:
        return DateTime(current.year, current.month, current.day + 1);
      case DeadlineRoutine.weekly:
        return DateTime(current.year, current.month, current.day + 7);
      case DeadlineRoutine.monthly:
        return DateTime(current.year, current.month + 1, current.day);
    }
  }

  final DateTime date;
  final DeadlineRoutine routine;

  Deadline({required this.date, required this.routine});

  bool get arrived => DateTime.now().isAfter(date);

  String get stringifiedRoutine => routine.name.capitalizeFirst!;

  Duration get timeRemain => date.difference(DateTime.now());

  DeadlineRoutine getNextRoutine() => DeadlineRoutine
      .values[(routine.index + 1) % DeadlineRoutine.values.length];

  Deadline copyWithChanges({DateTime? date, DeadlineRoutine? routine}) {
    return Deadline(
      date: date ?? this.date,
      routine: routine ?? this.routine,
    );
  }
}

class HabitTrackerController {
  static int _uniqueId = 0;
  static int get uniqueId => _uniqueId++;

  static Rx<int> selected = (-1).obs;

  static setSelected(int? id) {
    selected.value = id ?? -1;
  }

  final int id = uniqueId;
  Rx<String> name;
  Rx<Duration> duration;
  Rx<Duration> progress;
  RxBool playing;
  Rx<Deadline> deadline;

  Timer? _timer;

  HabitTrackerController({
    required String name,
    required Duration duration,
    required Duration progress,
    required bool playing,
    required Deadline deadline,
  })  : name = name.obs,
        duration = duration.obs,
        progress = progress.obs,
        playing = playing.obs,
        deadline = deadline.obs {
    togglePlaying(playing: this.playing.value);
    _initializeTimer();
  }

  bool get _emptyDuration => duration.value.inSeconds == 0;

  double get _toPrecent =>
      _emptyDuration ? 0 : progress.value.inSeconds / duration.value.inSeconds;

  double get toIndicator => _emptyDuration
      ? 0
      : progress.value.inSeconds > duration.value.inSeconds
          ? 1
          : _toPrecent;

  String get precentFormat => "${(_toPrecent * 100).floor()}%";

  bool get hasProgress => progress.value.inSeconds > 0;

  void _clearTimer() => _timer != null ? _timer!.cancel() : null;

  void _initializeTimer() {
    // Interval each second, updates progress and checks if deadline arrived
    // If deadline arrived, reset progress and set a new deadline based on it's routine
    _clearTimer();
    final keepTime = DateTime.now().subtract(progress.value);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (playing.value) {
        progress.value = DateTime.now().difference(keepTime);
      }
      if (deadline.value.arrived) {
        reset();
        deadline.value = deadline.value.copyWithChanges(
          date: Deadline.getNextDate(deadline.value.routine),
        );
      }
      // Update time remain
      deadline.value = deadline.value.copyWithChanges();
    });
  }

  void togglePlaying({bool? playing}) {
    // If playing set new keep time to track of
    this.playing.value = playing ?? !this.playing.value;
    if (this.playing.value) {
      _initializeTimer();
    }
  }

  void reset() {
    progress.value = const Duration();
    _initializeTimer();
  }

  void dispose() => _clearTimer();

  @override
  String toString() =>
      "${formatDuration(progress.value, DurationFormat.fixed)} / ${formatDuration(duration.value, DurationFormat.fixed)}";
}

/// * [shortened] -> 1d -> 23h -> 59m -> 59s
///
/// * [fixed] 1d 20h -> 1d -> 23h 11m -> 23h -> 10:05
///
/// * [detailed] 01:59:00
enum DurationFormat { shortened, fixed, detailed }

String formatDuration(Duration value, DurationFormat detailed) {
  final days = value.inDays;
  final hours = value.inHours % Duration.hoursPerDay;
  final minutes = value.inMinutes % Duration.minutesPerHour;
  final seconds = value.inSeconds % Duration.secondsPerMinute;
  final digitalTime =
      "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
  switch (detailed) {
    case DurationFormat.shortened:
      {
        return days > 0
            ? "${days}d"
            : hours > 0
                ? "${hours}h"
                : minutes > 0
                    ? "${minutes}m"
                    : "${seconds}s";
      }
    case DurationFormat.fixed:
      {
        if (days > 0) {
          return "${days}d${(hours > 0) ? " ${hours}h" : ""}";
        }
        if (hours > 0) {
          return "${hours}h${(minutes > 0) ? " ${minutes}m" : ""}";
        }

        return digitalTime;
      }
    case DurationFormat.detailed:
      {
        return "$hours:$digitalTime";
      }
  }
}
