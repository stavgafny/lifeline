class GlobalTime {
  static Stream<void> get onEveryDeviceSecond async* {
    final now = DateTime.now();
    await Future.delayed(
      Duration(
        milliseconds: now.millisecond,
        microseconds: now.microsecond,
      ),
    );
    while (true) {
      yield null;
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
