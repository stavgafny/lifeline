import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String formatDuration(Duration value, bool detailed) {
  if (detailed) {
    final hours = value.inHours.toString();
    final minutes = (value.inMinutes % 60).toString().padLeft(2, "0");
    final sesconds = (value.inSeconds % 60).toString().padLeft(2, "0");
    return "$hours:$minutes:$sesconds";
  }

  if (value.inHours > 0) {
    final minutes = value.inMinutes % 60;
    return "${value.inHours}h${(minutes > 0) ? " ${minutes}m" : ""}";
  }

  final minutes = (value.inMinutes % 60).toString().padLeft(2, "0");
  final sesconds = (value.inSeconds % 60).toString().padLeft(2, "0");
  return "$minutes:$sesconds";
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
  Rx<TimeOfDay> deadline;

  Timer? _timer;

  HabitTrackerController({
    required String name,
    required Duration duration,
    required Duration progress,
    required bool playing,
    required TimeOfDay deadline,
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
    _clearTimer();
    final keepTime = DateTime.now().subtract(progress.value);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (playing.value) {
        progress.value = DateTime.now().difference(keepTime);
      }
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
    togglePlaying(playing: false);
  }

  @override
  String toString({bool detailed = false}) {
    return "${formatDuration(progress.value, detailed)} / ${formatDuration(duration.value, detailed)}";
  }
}
