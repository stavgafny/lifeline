import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Returns as string with a zero before if only one digit
String _leadingZero(int value) {
  return value.toString().padLeft(2, "0");
}

class Deadline extends GetxController {
  /// Stream that yields on every system second
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

  /// Get the next date with given days and the time to reset
  ///
  /// If current time is before reset time then subtracts 1 day
  static DateTime _getDate(int days, TimeOfDay time) {
    final current = DateTime.now();
    if (current.isBefore(DateTime(
        current.year, current.month, current.day, time.hour, time.minute))) {
      days--;
    }
    final value = DateTime.now().add(Duration(days: days));
    return DateTime(value.year, value.month, value.day, time.hour, time.minute);
  }

  /// Modifies deadline and updates date accourdingly after
  ///
  /// If no date given, get next one instead of old date
  static void modify(Rx<Deadline> deadline,
      {int? days, TimeOfDay? time, bool? active, DateTime? date}) {
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

  /// If not given date get next date form given days and time
  ///
  /// Set [timeRemain] accordingly to date, sets observables
  Deadline(
      {required this.days,
      required this.time,
      DateTime? date,
      required bool active})
      : date = date ?? _getDate(days, time),
        timeRemain =
            (date ?? _getDate(days, time)).difference(DateTime.now()).obs,
        active = active.obs;

  /// Check if deadline arrived by comparing to current [DateTime]
  bool get arrived => DateTime.now().isAfter(date);

  /// Returns deadline as formatted string with leading zero
  String get stringifedTime =>
      "${_leadingZero(time.hour)}:${_leadingZero(time.minute)}";

  /// Returns deadline's time remain until arrived
  void updateTimeRemain() => timeRemain.value = date.difference(DateTime.now());
}

class GoalTrackerController extends GetxController {
  /// Selected tracker from the list of trackers
  static Rx<GoalTrackerController?> selected = Rx(null);

  /// Set new tracker to be selected, null means all trackers are deselected
  static void setSelected(GoalTrackerController? tracker) {
    selected.value = tracker;
  }

  /// Creates a baseline instance with empty values
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

  //! Properties
  Rx<String> name;
  Rx<Duration> duration;
  Rx<Duration> progress;
  RxBool playing;
  Rx<Deadline> deadline;

  GoalTrackerTransitionController transitionController;

  /// [Timer] object when starting to tick each second to update progress
  Timer? _timer;

  /// [DateTime] keep track how much time has passed(progress)
  DateTime? _keepTime;

  /// [DateTime] to make sure that on [_initializeTimer] of playing controller
  /// that the [_keepTime] stays the same as it was
  final DateTime? _keptTime;

  /// [DateTime] that holds the date of when played
  DateTime? _keepDate;

  /// [DateTime] so [_initializeTimer] won't remake [_keepDate] on constructor
  final DateTime? _keptDate;

  /// Global listener for every second to update deadline
  StreamSubscription<void>? _globalTimeChangeListener;

  /// Sets observables, and a new [GoalTrackerTransitionController] instance
  ///
  /// Sets listener to listen for every second change and update deadline
  ///
  /// Toggles playing in case that is true to call [_initializeTimer]
  ///
  /// Calls [_updateDeadline] to update tracker's deadline if arrived already
  GoalTrackerController({
    required String name,
    required Duration duration,
    required Duration progress,
    required bool playing,
    required Deadline deadline,
    DateTime? keptTime,
    DateTime? keptDate,
  })  : name = name.obs,
        duration = duration.obs,
        progress = progress.obs,
        playing = playing.obs,
        deadline = deadline.obs,
        _keptTime = keptTime,
        _keptDate = keptDate,
        transitionController = GoalTrackerTransitionController() {
    _globalTimeChangeListener = Deadline.onGlobalTimeChange().listen(
      (event) => _updateDeadline(),
    );
    togglePlaying(playing: this.playing.value);
    _updateDeadline();
  }

  /// Whether duration is empty(0)
  bool get _emptyDuration => duration.value.inSeconds == 0;

  /// Returns progress duration ratio
  double get _getRatio =>
      _emptyDuration ? 0 : progress.value.inSeconds / duration.value.inSeconds;

  /// Same as [_getRatio] only capped to maximum of 1
  double get toIndicator => min(_getRatio, 1);

  /// Stringified precent of progress duration ratio
  String get precentFormat => "${(_getRatio * 100).floor()}%";

  /// If progress is not an empty duration
  bool get hasProgress => progress.value.inSeconds > 0;

  /// Stops [_timer] if exists
  void _clearTimer() => _timer != null ? _timer!.cancel() : null;

  /// Set [_keepTime] to current time minus progress to track from that time
  ///
  /// Interval each second and update progress
  ///
  /// If [_keepTime] null and [_keptTime] not, first call, set to [_keptTime]
  void _initializeTimer() {
    if (_keepTime == null && _keptTime != null) {
      _keepTime = _keptTime;
      _keepDate = _keptDate ?? DateTime.now();
    } else {
      _keepDate = DateTime.now();
      _keepTime = _keepDate!.subtract(progress.value);
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Ticks update to display, actual time is in keepTime
      progress.value = DateTime.now().difference(_keepTime!);
    });
  }

  /// Updates time remain, if arrived set to next date and reset progress
  ///
  /// If resets progress while is playing, sets the progress to the amount of
  /// time passed since the previous deadline (after modifying to the new date)
  ///
  /// Uses previous deadline after modify as opposed to the current unmodified
  /// deadline to avoid multiplying the value with the amout of resets (modulo)
  void _updateDeadline() {
    deadline.value.updateTimeRemain();

    if (!deadline.value.arrived) return;
    Deadline.modify(deadline);

    if (!deadline.value.active.value) return;
    if (playing.value) {
      refreshTimer(() {
        final previousDeadline =
            deadline.value.date.subtract(Duration(days: deadline.value.days));
        progress.value = DateTime.now().difference(previousDeadline);
      });
    } else {
      reset();
    }
  }

  /// Stops potential timer, calls given callback, resumes if timer was playing
  void refreshTimer(Function callback) {
    _clearTimer();
    callback();
    if (playing.value) _initializeTimer();
  }

  /// Resets progress to empty duration
  void reset() {
    refreshTimer(() => progress.value = const Duration());
  }

  /// Set playing to given value, if null toggle to opposite of current playing
  ///
  /// Call inside [refreshTimer] to correspond with [_timer]
  void togglePlaying({bool? playing}) {
    refreshTimer(() => this.playing.value = playing ?? !this.playing.value);
  }

  /// Dispose and Stop potential timer
  @override
  void dispose() {
    deadline.value.dispose();
    _globalTimeChangeListener?.cancel();
    _clearTimer();
    super.dispose();
  }

  /// Stringified "progress / duration" as formatted detailed
  @override
  String toString() =>
      "${formatDuration(progress.value, DurationFormat.detailed)} / ${formatDuration(duration.value, DurationFormat.detailed)}";

  /// Converts json to new [GoalTrackerController] instance
  ///
  /// If playing, json progress is [_keepTime]
  static GoalTrackerController fromJson(Map<String, dynamic> json) {
    bool isPlaynig = json["playing"] != "F";
    int timeOfDay = int.parse(json["deadline_time"]);

    final tracker = GoalTrackerController(
      name: json["name"],
      duration: Duration(milliseconds: int.parse(json["duration"])),
      progress: isPlaynig
          ? DateTime.now().difference(
              DateTime.fromMillisecondsSinceEpoch(int.parse(json["progress"])))
          : Duration(milliseconds: int.parse(json["progress"])),
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
          ? DateTime.fromMillisecondsSinceEpoch(int.parse(json["progress"]))
          : null,
      keptDate: isPlaynig
          ? DateTime.fromMillisecondsSinceEpoch(int.parse(json["playing"]))
          : null,
    );
    return tracker;
  }

  /// Converts current [GoalTrackerController] to a json object
  ///
  /// If playing, set progress to [_keepTime] if not, set to it's progress value
  Map<String, dynamic> toJson() {
    final isPlaying = playing.value && _keepTime != null;
    return {
      "name": name.value,
      "duration": duration.value.inMilliseconds.toString(),
      "progress": isPlaying
          ? _keepTime!.millisecondsSinceEpoch.toString()
          : progress.value.inMilliseconds.toString(),
      "playing": isPlaying
          ? (_keepDate ?? DateTime.now()).millisecondsSinceEpoch.toString()
          : "F",
      "deadline_date": deadline.value.date.millisecondsSinceEpoch.toString(),
      "deadline_days": deadline.value.days.toString(),
      "deadline_time": ((deadline.value.time.hour * Duration.minutesPerHour) +
              deadline.value.time.minute)
          .toString(),
      "deadline_active": deadline.value.active.value ? "T" : "F",
    };
  }
}

/// * [absolute] 3:12:59:25
///
/// * [shortened] > |d > |h > |m > |s
///
/// * [detailed] |d? |h? (|m?|s?) > |m? |s? > 0s
enum DurationFormat { absolute, shortened, detailed }

/// Formats given [Duration] based on given [DurationFormat]
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

/// Responsible to make a transition animation to goal the tracker widget
class GoalTrackerTransitionController {
  /// Transition animation duration constant
  static const Duration duration = Duration(milliseconds: 325);

  AnimationController? controller;
  final bool animateIn;

  /// [animateIn] is false on defualt
  GoalTrackerTransitionController({this.animateIn = false});

  Future<void> fadeIn() async => await controller?.forward(from: 0);

  Future<void> fadeOut() async => await controller?.animateTo(0);
}
