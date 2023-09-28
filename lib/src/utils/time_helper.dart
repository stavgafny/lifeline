class DurationHelper {
  static String formatDuration(Duration duration, {bool secondary = false}) {
    final timeFormats = <String>[];

    final days = duration.inDays;
    final hours = duration.inHours.remainder(Duration.hoursPerDay);
    final minutes = duration.inMinutes.remainder(Duration.minutesPerHour);
    final seconds = duration.inSeconds.remainder(Duration.secondsPerMinute);

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
}
