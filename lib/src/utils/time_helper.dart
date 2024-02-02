/// Returns as string with a zero before if only one digit
String _leadingZero(int value) => value.toString().padLeft(2, "0");

String _formatDuration(Duration duration, DurationFormatType formatType) {
  final days = duration.inDays.abs();
  final hours = duration.inHours.remainder(Duration.hoursPerDay).abs();
  final minutes = duration.inMinutes.remainder(Duration.minutesPerHour).abs();
  final seconds = duration.inSeconds.remainder(Duration.secondsPerMinute).abs();

  switch (formatType) {
    case DurationFormatType.absolute:
      return "$days:${_leadingZero(hours)}:${_leadingZero(minutes)}:${_leadingZero(seconds)}";

    case DurationFormatType.compact:
      return days > 0
          ? "${days}d"
          : hours > 0
              ? "${hours}h"
              : minutes > 0
                  ? "${minutes}m"
                  : "${seconds}s";

    case DurationFormatType.extended:
      return ("${days > 0 ? "${days}d" : ""}"
              "${hours > 0 ? " ${hours}h" : ""}"
              "${minutes > 0 ? " ${minutes}m" : ""}"
              "${seconds > 0 && !((days > 0 || hours > 0) && minutes > 0) ? " ${seconds}s" : ""}")
          .padRight(1, " 0s")
          .trim();
  }
}

/// * [absolute] d:hh:mm:ss
///
/// * [compact] d > h > m > s > 0s
///
/// * [extended] d:h(m?|s?) > h:(m?|s?) > m:s? > s? > 0s
enum DurationFormatType { absolute, compact, extended }

extension DurationExtension on Duration {
  String format(DurationFormatType formatType) {
    final formatted = _formatDuration(this, formatType);
    return isNegative ? "-$formatted" : formatted;
  }

  Duration trimSubseconds() {
    final subSeconds = inMicroseconds.remainder(Duration.microsecondsPerSecond);
    return this - Duration(microseconds: subSeconds);
  }

  Duration remainder(Duration other) {
    if (other == Duration.zero) return this;
    return Duration(
      microseconds: inMicroseconds.remainder(other.inMicroseconds),
    );
  }
}

extension DateTimeExtension on DateTime {
  /// Excluding seconds and sub-seconds.
  DateTime asFixed() => DateTime(year, month, day, hour, minute);

  /// Excluding time information.
  DateTime dateOnly() => DateTime(year, month, day);

  String formatDDMMYYYY() => "$day/$month/$year";
}
