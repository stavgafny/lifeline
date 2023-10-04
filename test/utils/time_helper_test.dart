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

    group('Duration.getNextUpdate', () {
      group('--no-secondary', () {
        test('1 second', () {
          expect(
            const Duration(seconds: 1).getNextUpdate(),
            const Duration(seconds: 1),
          );
        });
        test('1 minute', () {
          expect(
            const Duration(minutes: 1).getNextUpdate(),
            const Duration(minutes: 1),
          );
        });
        test('1 hour', () {
          expect(
            const Duration(hours: 1).getNextUpdate(),
            const Duration(hours: 1),
          );
        });
        test('1 day', () {
          expect(
            const Duration(days: 1).getNextUpdate(),
            const Duration(days: 1),
          );
        });

        test('1 minute 1 second', () {
          expect(
            const Duration(minutes: 1, seconds: 1).getNextUpdate(),
            const Duration(seconds: 1),
          );
        });
        test('1 day 1 second', () {
          expect(
            const Duration(days: 1, seconds: 1).getNextUpdate(),
            const Duration(seconds: 1),
          );
        });
        test('1 day 1 minute', () {
          expect(
            const Duration(days: 1, minutes: 1).getNextUpdate(),
            const Duration(minutes: 1),
          );
        });
        test('1 day 1 minute 1 second', () {
          expect(
            const Duration(days: 1, minutes: 1, seconds: 1).getNextUpdate(),
            const Duration(minutes: 1, seconds: 1),
          );
        });
      });

      group('--secondary', () {
        test('1 second', () {
          expect(
            const Duration(seconds: 1).getNextUpdate(secondary: true),
            const Duration(seconds: 1),
          );
        });
        test('1 minute', () {
          expect(
            const Duration(minutes: 1).getNextUpdate(secondary: true),
            const Duration(seconds: 1),
          );
        });
        test('1 hour', () {
          expect(
            const Duration(hours: 1).getNextUpdate(secondary: true),
            const Duration(seconds: 1),
          );
        });
        test('1 day', () {
          expect(
            const Duration(days: 1).getNextUpdate(secondary: true),
            const Duration(seconds: 1),
          );
        });

        test('1 minute 1 second', () {
          expect(
            const Duration(minutes: 1, seconds: 1)
                .getNextUpdate(secondary: true),
            const Duration(seconds: 1),
          );
        });
        test('1 day 1 second', () {
          expect(
            const Duration(days: 1, seconds: 1).getNextUpdate(secondary: true),
            const Duration(seconds: 1),
          );
        });
        test('1 day 1 minute', () {
          expect(
            const Duration(days: 1, minutes: 1).getNextUpdate(secondary: true),
            const Duration(minutes: 1),
          );
        });
        test('1 day 1 minute 1 second', () {
          expect(
            const Duration(days: 1, minutes: 1, seconds: 1)
                .getNextUpdate(secondary: true),
            const Duration(seconds: 1),
          );
        });
      });
    });

    group('Duration.trimSubseconds {extention}', () {
      test('trimSubseconds removes subseconds correctly', () {
        expect(
          const Duration(seconds: 2, milliseconds: 500).trimSubseconds(),
          equals(const Duration(seconds: 2)),
        );

        expect(
          const Duration(minutes: 1, milliseconds: 750).trimSubseconds(),
          equals(const Duration(minutes: 1)),
        );

        expect(
          const Duration(milliseconds: 500).trimSubseconds(),
          equals(const Duration(seconds: 0)),
        );

        expect(
          const Duration(seconds: 10).trimSubseconds(),
          equals(const Duration(seconds: 10)),
        );
      });

      test('trimSubseconds handles zero duration', () {
        expect(
          const Duration(seconds: 0).trimSubseconds(),
          equals(const Duration(seconds: 0)),
        );
      });
    });
  });
}
