import 'dart:async';

import 'package:get/get.dart';

class Tracker {
  final int id;
  Rx<Duration> duration;
  Rx<Duration> progress;
  RxBool playing;

  late DateTime keepTime;
  Timer? _timer;

  Tracker({
    required this.id,
    required this.duration,
    required this.progress,
    required this.playing,
  }) {
    togglePlaying(playing: playing.value);
  }

  double get toPrecent => progress.value.inSeconds / duration.value.inSeconds;

  double get toIndicator =>
      progress.value.inSeconds > duration.value.inSeconds ? 1 : toPrecent;

  String get precentFormat => "${(toPrecent * 100).floor()}%";

  void clearTimer() => _timer != null ? _timer!.cancel() : null;

  void togglePlaying({bool? playing}) {
    this.playing.value = playing ?? !this.playing.value;
    if (this.playing.value) {
      start();
    } else {
      stop();
    }
  }

  void start() {
    clearTimer();
    keepTime = DateTime.now().subtract(progress.value);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      progress.value = DateTime.now().difference(keepTime);
    });
  }

  void stop() {
    clearTimer();
  }

  String format(Duration value) {
    if (value.inDays > 0) return "${value.inDays}d";
    if (value.inHours > 0) return "${value.inHours}h";
    final stringifiedMinutes = (value.inMinutes).toString().padLeft(2, "0");
    final stringifiedSeconds =
        (value.inSeconds % 60).toString().padLeft(2, "0");
    return "$stringifiedMinutes:$stringifiedSeconds";
  }

  @override
  String toString() {
    return "${format(progress.value)} / ${format(duration.value)}";
  }
}

class HabitTrackersController extends GetxController {
  List<Tracker> trackers = [];
  HabitTrackersController();

  Tracker createTracker(
    int id, {
    required Duration duration,
    required Duration progress,
    required bool playing,
  }) {
    final tracker = Tracker(
      id: id,
      duration: duration.obs,
      progress: progress.obs,
      playing: playing.obs,
    );
    trackers.add(tracker);
    return tracker;
  }
}
