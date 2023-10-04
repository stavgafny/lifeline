extension DurationExtension on Duration {
  String format({bool secondary = false}) {
    final timeFormats = <String>[];
    final days = inDays;
    final hours = inHours.remainder(Duration.hoursPerDay);
    final minutes = inMinutes.remainder(Duration.minutesPerHour);
    final seconds = inSeconds.remainder(Duration.secondsPerMinute);

    if (days.abs() > 0) timeFormats.add("${days}d");
    if (hours.abs() > 0) timeFormats.add("${hours}h");
    if (minutes.abs() > 0) timeFormats.add("${minutes}m");

    // Seconds must be applicable (so case with secondary: 4m 0s becomes 4m)
    if (timeFormats.isEmpty || seconds.abs() > 0) {
      timeFormats.add("${seconds}s");
    }
    String secondaryTime = "";
    if (secondary && timeFormats.length > 1) {
      // replace leading '-' if has one so -1h -1m becomes -1h 1m
      secondaryTime = " ${timeFormats[1].replaceAll('-', '')}";
    }
    return timeFormats.first + secondaryTime;
  }

  Duration getNextUpdate({bool secondary = false}) {
    final days = inDays;
    final hours = inHours.remainder(Duration.hoursPerDay);
    final minutes = inMinutes.remainder(Duration.minutesPerHour);

    final timeFactors = <int>[];

    if (days.abs() > 0) timeFactors.add(Duration.microsecondsPerDay);
    if (hours.abs() > 0) timeFactors.add(Duration.microsecondsPerHour);
    if (minutes.abs() > 0) timeFactors.add(Duration.microsecondsPerMinute);
    timeFactors.add(Duration.microsecondsPerSecond);

    final timeFactor = secondary && timeFactors.length > 1
        ? timeFactors[1]
        : timeFactors.first;

    final value = inMicroseconds.remainder(timeFactor);
    return Duration(microseconds: value > 0 ? value : timeFactor);
  }

  Duration trimSubseconds() {
    return this -
        Duration(
          microseconds: inMicroseconds.remainder(
            Duration.microsecondsPerSecond,
          ),
        );
  }
}
