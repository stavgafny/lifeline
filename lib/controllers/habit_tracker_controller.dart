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

  @override
  String toString({bool detailed = false}) {
    return "${_format(progress.value, detailed)} / ${_format(duration.value, detailed)}";
  }

  String _format(Duration value, bool detailed) {
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
