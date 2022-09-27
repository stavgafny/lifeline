import 'dart:async';
import 'package:get/get.dart';

enum DeadlineRoutine { daily, weekly, monthly }

class Deadline extends GetxController {
  static Stream<void> onGlobalTimeChange() async* {
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
  final Rx<Duration> timeRemain;

  Deadline({required this.date, required this.routine})
      : timeRemain = date.difference(DateTime.now()).obs;

  bool get arrived => DateTime.now().isAfter(date);

  String get stringifiedRoutine => routine.name.capitalizeFirst!;

  void updateTimeRemain() => timeRemain.value = date.difference(DateTime.now());

  DeadlineRoutine getNextRoutine() => DeadlineRoutine
      .values[(routine.index + 1) % DeadlineRoutine.values.length];

  Deadline copyWithChanges({DateTime? date, DeadlineRoutine? routine}) {
    //! dispose's timeRemain observable
    dispose();
    return Deadline(
      date: date ?? this.date,
      routine: routine ?? this.routine,
    );
  }
}

class GoalTrackerController extends GetxController {
  static int _uniqueId = 0;
  static int get uniqueId => _uniqueId++;

  // Selected tracker from the list of trackers
  static Rx<int> selected = (-1).obs;

  static void setSelected(int? id) {
    selected.value = id ?? -1;
  }

  final int id = uniqueId;
  Rx<String> name;
  Rx<Duration> duration;
  Rx<Duration> progress;
  RxBool playing;
  Rx<Deadline> deadline;

  Timer? _timer;
  DateTime? keepTime;
  final List<StreamSubscription<void>> _listeners = [];

  GoalTrackerController({
    required String name,
    required Duration duration,
    required Duration progress,
    required bool playing,
    required Deadline deadline,
    DateTime? keptTime,
  })  : name = name.obs,
        duration = duration.obs,
        progress = keptTime != null
            ? (DateTime.now().difference(keptTime)).obs
            : progress.obs,
        playing = playing.obs,
        deadline = deadline.obs {
    _listeners.addAll([
      Deadline.onGlobalTimeChange().listen((event) => _updateDeadline()),
    ]);
    togglePlaying(playing: this.playing.value);
    _updateDeadline();
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

  void refreshTimer(Function callback) {
    // Stops potential timer and after callback is called, resumes if timer was playing
    _clearTimer();
    callback();
    if (playing.value) _initializeTimer();
  }

  void reset() {
    // Resets progress
    refreshTimer(() => progress.value = const Duration());
  }

  void _initializeTimer() {
    // Interval each second and updates progress

    // Set new time to keep track of
    keepTime = DateTime.now().subtract(progress.value);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Ticks update to display, actual time is in keepTime
      progress.value = DateTime.now().difference(keepTime!);
    });
  }

  void _updateDeadline() {
    // Update time remain
    deadline.value.updateTimeRemain();

    // If deadline arrived, reset progress and set a new deadline based on it's routine
    if (deadline.value.arrived) {
      reset();
      deadline.value = deadline.value
          .copyWithChanges(date: Deadline.getNextDate(deadline.value.routine));
    }
  }

  void togglePlaying({bool? playing}) {
    refreshTimer(() => this.playing.value = playing ?? !this.playing.value);
  }

  @override
  void dispose() {
    //! emits to storage, dispose's observables, listeners(global time, storage update) and timer
    deadline.value.dispose();
    for (var listener in _listeners) {
      listener.cancel();
    }
    _clearTimer();
    super.dispose();
  }

  @override
  String toString() =>
      "${formatDuration(progress.value, DurationFormat.fixed)} / ${formatDuration(duration.value, DurationFormat.fixed)}";

  static GoalTrackerController fromJson(Map<String, dynamic> json) {
    bool isPlaynig = json["playing"] != "F";
    final tracker = GoalTrackerController(
      name: json["name"],
      duration: Duration(milliseconds: int.parse(json["duration"])),
      progress: Duration(milliseconds: int.parse(json["progress"])),
      playing: isPlaynig,
      deadline: Deadline(
        date: DateTime.fromMillisecondsSinceEpoch(
            int.parse(json["deadline_date"])),
        routine: DeadlineRoutine.values.byName(json["deadline_rotuine"]),
      ),
      keptTime: isPlaynig
          ? DateTime.fromMillisecondsSinceEpoch(int.parse(json["playing"]))
          : null,
    );
    return tracker;
  }

  Map<String, dynamic> toJson() => {
        // Returns F if not playing, else, returns time kept when started (unix time)
        "name": name.value,
        "duration": duration.value.inMilliseconds.toString(),
        "progress": progress.value.inMilliseconds.toString(),
        "playing": (playing.value & (keepTime != null))
            ? keepTime!.millisecondsSinceEpoch.toString()
            : "F",
        "deadline_date": deadline.value.date.millisecondsSinceEpoch.toString(),
        "deadline_rotuine": deadline.value.routine.name,
      };
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
