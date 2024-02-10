class GlobalTime {
  static Stream<void> get onEveryDeviceSecond async* {
    final now = DateTime.now();
    final micro = Duration.microsecondsPerMillisecond - now.microsecond;
    final mil = Duration.millisecondsPerSecond - now.millisecond;
    await Future.delayed(Duration(milliseconds: mil, microseconds: micro));

    while (true) {
      yield null;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  /// yields every time the clock strikes at midnight
  static Stream<void> atMidnight() async* {
    while (true) {
      final now = DateTime.now();
      final midnight =
          DateTime(now.year, now.month, now.day + 1).difference(now);
      await Future.delayed(midnight);
      yield null;
    }
  }
}
