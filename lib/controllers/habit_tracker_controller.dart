import 'dart:async';
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

  Timer? _timer;
  late DateTime _keepTime;

  HabitTrackerController({
    required String name,
    required Duration duration,
    required Duration progress,
    required bool playing,
  }) {
    this.name = name.obs;
    this.duration = duration.obs;
    this.progress = progress.obs;
    this.playing = playing.obs;
    togglePlaying(playing: this.playing.value);
  }

  double get _toPrecent => progress.value.inSeconds / duration.value.inSeconds;

  double get toIndicator =>
      progress.value.inSeconds > duration.value.inSeconds ? 1 : _toPrecent;

  String get precentFormat => "${(_toPrecent * 100).floor()}%";

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
    _keepTime = DateTime.now().subtract(progress.value);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      progress.value = DateTime.now().difference(_keepTime);
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
