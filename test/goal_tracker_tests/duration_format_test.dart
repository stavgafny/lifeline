import 'package:flutter_test/flutter_test.dart';
import 'package:lifeline/controllers/goal_tracker_controller.dart';

void _testFormats({
  required Duration duration,
  required String absolute,
  required String shortened,
  required String detailed,
}) {
  test("absolute", () {
    expect(formatDuration(duration, DurationFormat.absolute), absolute);
  });
  test("shortened", () {
    expect(formatDuration(duration, DurationFormat.shortened), shortened);
  });
  test("detailed", () {
    expect(formatDuration(duration, DurationFormat.detailed), detailed);
  });
}

void main() {
  group("0s", () {
    _testFormats(
      duration: const Duration(),
      absolute: "0:0:00:00",
      shortened: "0s",
      detailed: "0s",
    );
  });
  group("1s", () {
    _testFormats(
      duration: const Duration(seconds: 1),
      absolute: "0:0:00:01",
      shortened: "1s",
      detailed: "1s",
    );
  });
  group("1m 0s", () {
    _testFormats(
      duration: const Duration(minutes: 1),
      absolute: "0:0:01:00",
      shortened: "1m",
      detailed: "1m",
    );
  });
  group("1m 1s", () {
    _testFormats(
      duration: const Duration(minutes: 1, seconds: 1),
      absolute: "0:0:01:01",
      shortened: "1m",
      detailed: "1m 1s",
    );
  });
  group("1h 0m 0s", () {
    _testFormats(
      duration: const Duration(hours: 1),
      absolute: "0:1:00:00",
      shortened: "1h",
      detailed: "1h",
    );
  });
  group("1h 0m 1s", () {
    _testFormats(
      duration: const Duration(hours: 1, seconds: 1),
      absolute: "0:1:00:01",
      shortened: "1h",
      detailed: "1h 1s",
    );
  });
  group("1h 1m 0s", () {
    _testFormats(
      duration: const Duration(hours: 1, minutes: 1),
      absolute: "0:1:01:00",
      shortened: "1h",
      detailed: "1h 1m",
    );
  });
  group("1h 1m 1s", () {
    _testFormats(
      duration: const Duration(hours: 1, minutes: 1, seconds: 1),
      absolute: "0:1:01:01",
      shortened: "1h",
      detailed: "1h 1m",
    );
  });
  group("1d 0h 0m 0s", () {
    _testFormats(
      duration: const Duration(days: 1),
      absolute: "1:0:00:00",
      shortened: "1d",
      detailed: "1d",
    );
  });
  group("1d 0h 0m 1s", () {
    _testFormats(
      duration: const Duration(days: 1, seconds: 1),
      absolute: "1:0:00:01",
      shortened: "1d",
      detailed: "1d 1s",
    );
  });
  group("1d 0h 1m 0s", () {
    _testFormats(
      duration: const Duration(days: 1, minutes: 1),
      absolute: "1:0:01:00",
      shortened: "1d",
      detailed: "1d 1m",
    );
  });
  group("1d 0h 1m 1s", () {
    _testFormats(
      duration: const Duration(days: 1, minutes: 1, seconds: 1),
      absolute: "1:0:01:01",
      shortened: "1d",
      detailed: "1d 1m",
    );
  });

  group("1d 1h 0m 0s", () {
    _testFormats(
      duration: const Duration(days: 1, hours: 1),
      absolute: "1:1:00:00",
      shortened: "1d",
      detailed: "1d 1h",
    );
  });
  group("1d 1h 0m 1s", () {
    _testFormats(
      duration: const Duration(days: 1, hours: 1, seconds: 1),
      absolute: "1:1:00:01",
      shortened: "1d",
      detailed: "1d 1h 1s",
    );
  });
  group("1d 1h 1m 0s", () {
    _testFormats(
      duration: const Duration(days: 1, hours: 1, minutes: 1),
      absolute: "1:1:01:00",
      shortened: "1d",
      detailed: "1d 1h 1m",
    );
  });
  group("1d 1h 1m 1s", () {
    _testFormats(
      duration: const Duration(days: 1, hours: 1, minutes: 1, seconds: 1),
      absolute: "1:1:01:01",
      shortened: "1d",
      detailed: "1d 1h 1m",
    );
  });
}
