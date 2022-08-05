import 'dart:async';
import 'package:get/get.dart';

enum DeadlineRoutine { daily, weekly, monthly }

class Deadline {
  static Stream onGlobalTimeChange() async* {
    final time = DateTime.now();
    await Duration(
            milliseconds: time.millisecond, microseconds: time.microsecond)
        .delay();
    while (true) {
      await const Duration(seconds: 1).delay();
      yield null;
    }
  }

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

    Deadline.onGlobalTimeChange().listen((event) {
      // Update time remain
      this.deadline.value = this.deadline.value.copyWithChanges();

      // If deadline arrived, reset progress and set a new deadline based on it's routine
      if (this.deadline.value.arrived) {
        reset();
        this.deadline.value = this.deadline.value.copyWithChanges(
            date: Deadline.getNextDate(this.deadline.value.routine));
      }
    });
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
    // Interval each second and updates progress

    // Set new time to keep track of
    final keepTime = DateTime.now().subtract(progress.value);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      progress.value = DateTime.now().difference(keepTime);
    });
  }

  void togglePlaying({bool? playing}) {
    this.playing.value = playing ?? !this.playing.value;
    refresh(() {});
  }

  void refresh(Function callback) {
    // Stops potential timer and after callback is called, resumes if timer was playing
    _clearTimer();
    callback();
    if (playing.value) _initializeTimer();
  }

  void reset() {
    // Resets progress
    refresh(() => progress.value = const Duration());
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
