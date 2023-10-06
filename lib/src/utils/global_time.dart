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
}
