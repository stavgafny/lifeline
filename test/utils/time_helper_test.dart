import 'package:flutter_test/flutter_test.dart';
import 'package:lifeline/src/utils/time_helper.dart';

void main() {
  group('TimeHelper', () {
    group('Duration.format {extention}', () {
      group('--no-secondary', () {
        test('Empty duration', () {
          const duration = Duration();
          expect(duration.format(), '0s');
        });

        test('1 second', () {
          const duration = Duration(seconds: 1);
          expect(duration.format(), '1s');
        });

        test('1 minute', () {
          const duration = Duration(minutes: 1);
          expect(duration.format(), '1m');
        });

        test('1 hour', () {
          const duration = Duration(hours: 1);
          expect(duration.format(), '1h');
        });

        test('1 day', () {
          const duration = Duration(days: 1);
          expect(duration.format(), '1d');
        });

        test('1 minute and 1 second', () {
          const duration = Duration(minutes: 1, seconds: 1);
          expect(duration.format(), '1m');
        });

        test('1 hour and 1 minute', () {
          const duration = Duration(hours: 1, minutes: 1);
          expect(duration.format(), '1h');
        });

        test('1 hour and 1 second', () {
          const duration = Duration(hours: 1, seconds: 1);
          expect(duration.format(), '1h');
        });

        test('1 hour, 1 minute, and 1 second', () {
          const duration = Duration(hours: 1, minutes: 1, seconds: 1);
          expect(duration.format(), '1h');
        });
      });
      group('--secondary', () {
        test('Empty duration', () {
          const duration = Duration();
          expect(duration.format(secondary: true), '0s');
        });

        test('1 second', () {
          const duration = Duration(seconds: 1);
          expect(duration.format(secondary: true), '1s');
        });

        test('1 minute', () {
          const duration = Duration(minutes: 1);
          expect(duration.format(secondary: true), '1m');
        });

        test('1 hour', () {
          const duration = Duration(hours: 1);
          expect(duration.format(secondary: true), '1h');
        });

        test('1 day', () {
          const duration = Duration(days: 1);
          expect(duration.format(secondary: true), '1d');
        });

        test('1 minute and 1 second', () {
          const duration = Duration(minutes: 1, seconds: 1);
          expect(duration.format(secondary: true), '1m 1s');
        });

        test('1 hour and 1 minute', () {
          const duration = Duration(hours: 1, minutes: 1);
          expect(duration.format(secondary: true), '1h 1m');
        });

        test('1 hour and 1 second', () {
          const duration = Duration(hours: 1, seconds: 1);
          expect(duration.format(secondary: true), '1h 1s');
        });

        test('1 hour, 1 minute, and 1 second', () {
          const duration = Duration(hours: 1, minutes: 1, seconds: 1);
          expect(duration.format(secondary: true), '1h 1m');
        });
      });
      group('--negative', () {
        test('Negative 1 second', () {
          const duration = Duration(seconds: -1);
          expect(duration.format(), '-1s');
        });

        test('Negative 1 minute', () {
          const duration = Duration(minutes: -1);
          expect(duration.format(), '-1m');
        });

        test('Negative 1 hour', () {
          const duration = Duration(hours: -1);
          expect(duration.format(), '-1h');
        });

        test('Negative 1 day', () {
          const duration = Duration(days: -1);
          expect(duration.format(), '-1d');
        });

        test('Negative 1 minute and 1 second', () {
          const duration = Duration(minutes: -1, seconds: -1);
          expect(duration.format(), '-1m');
        });

        test('Negative 1 hour and 1 minute', () {
          const duration = Duration(hours: -1, minutes: -1);
          expect(duration.format(), '-1h');
        });

        test('Negative 1 hour and 1 second', () {
          const duration = Duration(hours: -1, seconds: -1);
          expect(duration.format(), '-1h');
        });

        test('Negative 1 hour, 1 minute, and 1 second', () {
          const duration = Duration(hours: -1, minutes: -1, seconds: -1);
          expect(duration.format(), '-1h');
        });
      });

      group('--negative-secondary', () {
        test('Negative 1 second', () {
          const duration = Duration(seconds: -1);
          expect(duration.format(secondary: true), '-1s');
        });

        test('Negative 1 minute', () {
          const duration = Duration(minutes: -1);
          expect(duration.format(secondary: true), '-1m');
        });

        test('Negative 1 hour', () {
          const duration = Duration(hours: -1);
          expect(duration.format(secondary: true), '-1h');
        });

        test('Negative 1 day', () {
          const duration = Duration(days: -1);
          expect(duration.format(secondary: true), '-1d');
        });

        test('Negative 1 minute and 1 second', () {
          const duration = Duration(minutes: -1, seconds: -1);
          expect(duration.format(secondary: true), '-1m 1s');
        });

        test('Negative 1 hour and 1 minute', () {
          const duration = Duration(hours: -1, minutes: -1);
          expect(duration.format(secondary: true), '-1h 1m');
        });

        test('Negative 1 hour and 1 second', () {
          const duration = Duration(hours: -1, seconds: -1);
          expect(duration.format(secondary: true), '-1h 1s');
        });

        test('Negative 1 hour, 1 minute, and 1 second', () {
          const duration = Duration(hours: -1, minutes: -1, seconds: -1);
          expect(duration.format(secondary: true), '-1h 1m');
        });
      });
    });
  });
}
