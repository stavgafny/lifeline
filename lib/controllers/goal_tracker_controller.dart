import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String _leadingZero(int value) {
  return value.toString().padLeft(2, "0");
}

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

  static DateTime _getDate(int days, TimeOfDay time) {
    // Get the next date with given days and the time to reset
    // If current time is before reset time then subtracts 1 day
    final current = DateTime.now();
    if (current.isBefore(DateTime(
        current.year, current.month, current.day, time.hour, time.minute))) {
      days--;
    }
    final value = DateTime.now().add(Duration(days: days));
    return DateTime(value.year, value.month, value.day, time.hour, time.minute);
  }

  static void modify(Rx<Deadline> deadline,
      {int? days, TimeOfDay? time, bool? active, DateTime? date}) {
    // Modifies deadline and updates date accourdingly after (if no date given, get next one instead of old date)
    //! dispose's active and timeRemain observables
    deadline.value.dispose();
    deadline.value = Deadline(
      days: days ?? deadline.value.days,
      time: time ?? deadline.value.time,
      active: active ?? deadline.value.active.value,
      date: date,
    );
  }

  final int days;
  final TimeOfDay time;
  final RxBool active;
  final Rx<Duration> timeRemain;
  final DateTime date;

  Deadline(
      {required this.days,
      required this.time,
      DateTime? date,
      required bool active})
      : date = date ?? _getDate(days, time),
        timeRemain =
            (date ?? _getDate(days, time)).difference(DateTime.now()).obs,
        active = active.obs;

  bool get arrived => DateTime.now().isAfter(date);

  String get stringifedTime =>
      "${_leadingZero(time.hour)}:${_leadingZero(time.minute)}";

  void updateTimeRemain() => timeRemain.value = date.difference(DateTime.now());
}

class GoalTrackerController extends GetxController {
  static int _uniqueId = 0;
  static int get uniqueId => _uniqueId++;

  // Selected tracker from the list of trackers
  static Rx<int> selected = (-1).obs;

  static void setSelected(int? id) {
    selected.value = id ?? -1;
  }

  static GoalTrackerController createEmpty() => GoalTrackerController(
        name: "",
        duration: const Duration(),
        progress: const Duration(),
        playing: false,
        deadline: Deadline(
          days: 1,
          time: const TimeOfDay(hour: 0, minute: 0),
          active: false,
        ),
      );

  final int id = uniqueId;
  Rx<String> name;
  Rx<Duration> duration;
  Rx<Duration> progress;
  RxBool playing;
  Rx<Deadline> deadline;
  Function onDeadlineReached = () {};

  Timer? _timer;
  DateTime? keepTime;
  final List<StreamSubscription<void>> _listeners = [];

  GoalTrackerTransitionController transitionController;

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
        deadline = deadline.obs,
        transitionController = GoalTrackerTransitionController() {
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

    // If deadline arrived, reset progress, set new deadline based on days and save to local storage
    if (deadline.value.arrived) {
      // Check if deadline is active to reset
      if (deadline.value.active.value) {
        reset();
      }
      Deadline.modify(deadline);
      onDeadlineReached();
    }
  }

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
      "${formatDuration(progress.value, DurationFormat.detailed)} / ${formatDuration(duration.value, DurationFormat.detailed)}";

  static GoalTrackerController fromJson(Map<String, dynamic> json) {
    bool isPlaynig = json["playing"] != "F";
    int timeOfDay = int.parse(json["deadline_time"]);
    final tracker = GoalTrackerController(
      name: json["name"],
      duration: Duration(milliseconds: int.parse(json["duration"])),
      progress: Duration(milliseconds: int.parse(json["progress"])),
      playing: isPlaynig,
      deadline: Deadline(
        date: DateTime.fromMillisecondsSinceEpoch(
            int.parse(json["deadline_date"])),
        days: int.parse(json["deadline_days"]),
        time: TimeOfDay(
          hour: timeOfDay ~/ Duration.minutesPerHour,
          minute: timeOfDay % Duration.minutesPerHour,
        ),
        active: json["deadline_active"] == "T",
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
        "deadline_days": deadline.value.days.toString(),
        "deadline_time": ((deadline.value.time.hour * Duration.minutesPerHour) +
                deadline.value.time.minute)
            .toString(),
        "deadline_active": deadline.value.active.value ? "T" : "F",
      };
}

/// * [absolute] 3:12:59:25
///
/// * [shortened] > |d > |h > |m > |s
///
/// * [detailed] |d? |h? (|m?|s?) > |m? |s? > 0s
enum DurationFormat { absolute, shortened, detailed }

String formatDuration(Duration value, DurationFormat format) {
  final days = value.inDays;
  final hours = value.inHours % Duration.hoursPerDay;
  final minutes = value.inMinutes % Duration.minutesPerHour;
  final seconds = value.inSeconds % Duration.secondsPerMinute;
  switch (format) {
    case DurationFormat.absolute:
      {
        return "$days:$hours:${_leadingZero(minutes)}:${_leadingZero(seconds)}";
      }

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

    case DurationFormat.detailed:
      {
        return ("${days > 0 ? "${days}d" : ""}"
                "${hours > 0 ? " ${hours}h" : ""}"
                "${minutes > 0 ? " ${minutes}m" : ""}"
                "${seconds > 0 && !((days > 0 || hours > 0) && minutes > 0) ? " ${seconds}s" : ""}")
            .padRight(1, " 0s")
            .trim();
      }
  }
}

class GoalTrackerTransitionController {
  static Duration duration = const Duration(milliseconds: 325);

  AnimationController? controller;
  final bool animateIn;
  GoalTrackerTransitionController({this.animateIn = false});

  Future<void> fadeIn() async {
    if (controller != null) {
      await controller!.forward(from: 0);
    }
  }

  Future<void> fadeOut() async {
    if (controller != null) {
      await controller!.animateTo(0);
    }
  }
}
