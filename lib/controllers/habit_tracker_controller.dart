import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HabitTrackerController {
  static int _uniqueId = 0;
  static int get uniqueId => _uniqueId++;

  static Rx<int> selected = (-1).obs;

  static setSelected(int? id) {
    selected.value = id ?? -1;
  }

  final int id = uniqueId;
  late final Rx<String> name;
  late final Rx<Duration> duration;
  late final Rx<Duration> progress;
  late final RxBool playing;
  late final Rx<TimeOfDay> deadline;

  Timer? _timer;
  late DateTime _keepTime;

  HabitTrackerController({
    required String name,
    required Duration duration,
    required Duration progress,
    required bool playing,
    required TimeOfDay deadline,
  }) {
    this.name = name.obs;
    this.duration = duration.obs;
    this.progress = progress.obs;
    this.playing = playing.obs;
    this.deadline = deadline.obs;

    togglePlaying(playing: this.playing.value);
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

  void _start() {
    playing.value = true;
    _clearTimer();
    _keepTime = DateTime.now().subtract(progress.value);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      progress.value = DateTime.now().difference(_keepTime);
    });
  }

  void _stop() {
    playing.value = false;
    _clearTimer();
  }

  void togglePlaying({bool? playing}) {
    playing = playing ?? !this.playing.value;
    if (playing) {
      _start();
    } else {
      _stop();
    }
  }

  void reset() {
    progress.value = const Duration();
    _stop();
  }

  @override
  String toString({bool detailed = false}) {
    return "${format(progress.value, detailed)} / ${format(duration.value, detailed)}";
  }

  String format(Duration value, bool detailed) {
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
}
