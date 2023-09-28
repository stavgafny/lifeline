import 'package:flutter_test/flutter_test.dart';
import 'package:lifeline/src/utils/time_helper.dart';

void main() {
  group('TimeHelper', () {
    group('.formatDuration --no-secondary', () {
      test('Empty duration', () {
        const duration = Duration();
        expect(DurationHelper.formatDuration(duration), '0s');
      });

      test('1 second', () {
        const duration = Duration(seconds: 1);
        expect(DurationHelper.formatDuration(duration), '1s');
      });

      test('1 minute', () {
        const duration = Duration(minutes: 1);
        expect(DurationHelper.formatDuration(duration), '1m');
      });

      test('1 hour', () {
        const duration = Duration(hours: 1);
        expect(DurationHelper.formatDuration(duration), '1h');
      });

      test('1 day', () {
        const duration = Duration(days: 1);
        expect(DurationHelper.formatDuration(duration), '1d');
      });

      test('1 minute and 1 second', () {
        const duration = Duration(minutes: 1, seconds: 1);
        expect(DurationHelper.formatDuration(duration), '1m');
      });

      test('1 hour and 1 minute', () {
        const duration = Duration(hours: 1, minutes: 1);
        expect(DurationHelper.formatDuration(duration), '1h');
      });

      test('1 hour and 1 second', () {
        const duration = Duration(hours: 1, seconds: 1);
        expect(DurationHelper.formatDuration(duration), '1h');
      });

      test('1 hour, 1 minute, and 1 second', () {
        const duration = Duration(hours: 1, minutes: 1, seconds: 1);
        expect(DurationHelper.formatDuration(duration), '1h');
      });
    });
    group('.formatDuration --secondary', () {
      test('Empty duration', () {
        const duration = Duration();
        expect(DurationHelper.formatDuration(duration, secondary: true), '0s');
      });

      test('1 second', () {
        const duration = Duration(seconds: 1);
        expect(DurationHelper.formatDuration(duration, secondary: true), '1s');
      });

      test('1 minute', () {
        const duration = Duration(minutes: 1);
        expect(DurationHelper.formatDuration(duration, secondary: true), '1m');
      });

      test('1 hour', () {
        const duration = Duration(hours: 1);
        expect(DurationHelper.formatDuration(duration, secondary: true), '1h');
      });

      test('1 day', () {
        const duration = Duration(days: 1);
        expect(DurationHelper.formatDuration(duration, secondary: true), '1d');
      });

      test('1 minute and 1 second', () {
        const duration = Duration(minutes: 1, seconds: 1);
        expect(
            DurationHelper.formatDuration(duration, secondary: true), '1m 1s');
      });

      test('1 hour and 1 minute', () {
        const duration = Duration(hours: 1, minutes: 1);
        expect(
            DurationHelper.formatDuration(duration, secondary: true), '1h 1m');
      });

      test('1 hour and 1 second', () {
        const duration = Duration(hours: 1, seconds: 1);
        expect(
            DurationHelper.formatDuration(duration, secondary: true), '1h 1s');
      });

      test('1 hour, 1 minute, and 1 second', () {
        const duration = Duration(hours: 1, minutes: 1, seconds: 1);
        expect(
            DurationHelper.formatDuration(duration, secondary: true), '1h 1m');
      });
    });
    group('.formatDuration --negative', () {
      test('Negative 1 second', () {
        const duration = Duration(seconds: -1);
        expect(DurationHelper.formatDuration(duration), '-1s');
      });

      test('Negative 1 minute', () {
        const duration = Duration(minutes: -1);
        expect(DurationHelper.formatDuration(duration), '-1m');
      });

      test('Negative 1 hour', () {
        const duration = Duration(hours: -1);
        expect(DurationHelper.formatDuration(duration), '-1h');
      });

      test('Negative 1 day', () {
        const duration = Duration(days: -1);
        expect(DurationHelper.formatDuration(duration), '-1d');
      });

      test('Negative 1 minute and 1 second', () {
        const duration = Duration(minutes: -1, seconds: -1);
        expect(DurationHelper.formatDuration(duration), '-1m');
      });

      test('Negative 1 hour and 1 minute', () {
        const duration = Duration(hours: -1, minutes: -1);
        expect(DurationHelper.formatDuration(duration), '-1h');
      });

      test('Negative 1 hour and 1 second', () {
        const duration = Duration(hours: -1, seconds: -1);
        expect(DurationHelper.formatDuration(duration), '-1h');
      });

      test('Negative 1 hour, 1 minute, and 1 second', () {
        const duration = Duration(hours: -1, minutes: -1, seconds: -1);
        expect(DurationHelper.formatDuration(duration), '-1h');
      });
    });

    group('.formatDuration --negative-secondary', () {
      test('Negative 1 second', () {
        const duration = Duration(seconds: -1);
        expect(DurationHelper.formatDuration(duration, secondary: true), '-1s');
      });

      test('Negative 1 minute', () {
        const duration = Duration(minutes: -1);
        expect(DurationHelper.formatDuration(duration, secondary: true), '-1m');
      });

      test('Negative 1 hour', () {
        const duration = Duration(hours: -1);
        expect(DurationHelper.formatDuration(duration, secondary: true), '-1h');
      });

      test('Negative 1 day', () {
        const duration = Duration(days: -1);
        expect(DurationHelper.formatDuration(duration, secondary: true), '-1d');
      });

      test('Negative 1 minute and 1 second', () {
        const duration = Duration(minutes: -1, seconds: -1);
        expect(
            DurationHelper.formatDuration(duration, secondary: true), '-1m 1s');
      });

      test('Negative 1 hour and 1 minute', () {
        const duration = Duration(hours: -1, minutes: -1);
        expect(
            DurationHelper.formatDuration(duration, secondary: true), '-1h 1m');
      });

      test('Negative 1 hour and 1 second', () {
        const duration = Duration(hours: -1, seconds: -1);
        expect(
            DurationHelper.formatDuration(duration, secondary: true), '-1h 1s');
      });

      test('Negative 1 hour, 1 minute, and 1 second', () {
        const duration = Duration(hours: -1, minutes: -1, seconds: -1);
        expect(
            DurationHelper.formatDuration(duration, secondary: true), '-1h 1m');
      });
    });
  });
}
