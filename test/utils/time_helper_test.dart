import 'package:flutter_test/flutter_test.dart';
import 'package:lifeline/src/utils/time_helper.dart';

void main() {
  group('TimeHelper', () {
    group('Duration.format {extention}', () {
      void testFormats({
        required String name,
        required Duration duration,
        required String absolute,
        required String compact,
        required String extended,
      }) {
        group(name, () {
          test("absolute", () {
            expect(duration.format(DurationFormatType.absolute), absolute);
          });
          test("compact", () {
            expect(duration.format(DurationFormatType.compact), compact);
          });
          test("extended", () {
            expect(duration.format(DurationFormatType.extended), extended);
          });
        });
      }

      group('--positive', () {
        testFormats(
          name: "0s",
          duration: const Duration(),
          absolute: "0:00:00:00",
          compact: "0s",
          extended: "0s",
        );
        testFormats(
          name: "1s",
          duration: const Duration(seconds: 1),
          absolute: "0:00:00:01",
          compact: "1s",
          extended: "1s",
        );
        testFormats(
          name: "1m 0s",
          duration: const Duration(minutes: 1),
          absolute: "0:00:01:00",
          compact: "1m",
          extended: "1m",
        );
        testFormats(
          name: "1m 1s",
          duration: const Duration(minutes: 1, seconds: 1),
          absolute: "0:00:01:01",
          compact: "1m",
          extended: "1m 1s",
        );
        testFormats(
          name: "1h 0m 0s",
          duration: const Duration(hours: 1),
          absolute: "0:01:00:00",
          compact: "1h",
          extended: "1h",
        );
        testFormats(
          name: "1h 0m 1s",
          duration: const Duration(hours: 1, seconds: 1),
          absolute: "0:01:00:01",
          compact: "1h",
          extended: "1h 1s",
        );
        testFormats(
          name: "1h 1m",
          duration: const Duration(hours: 1, minutes: 1),
          absolute: "0:01:01:00",
          compact: "1h",
          extended: "1h 1m",
        );
        testFormats(
          name: "1h 1m 1s",
          duration: const Duration(hours: 1, minutes: 1, seconds: 1),
          absolute: "0:01:01:01",
          compact: "1h",
          extended: "1h 1m",
        );
        testFormats(
          name: "1d 0h 0m 0s",
          duration: const Duration(days: 1),
          absolute: "1:00:00:00",
          compact: "1d",
          extended: "1d",
        );
        testFormats(
          name: "1d 0h 0m 1s",
          duration: const Duration(days: 1, seconds: 1),
          absolute: "1:00:00:01",
          compact: "1d",
          extended: "1d 1s",
        );
        testFormats(
          name: "1d 0h 1m 0s",
          duration: const Duration(days: 1, minutes: 1),
          absolute: "1:00:01:00",
          compact: "1d",
          extended: "1d 1m",
        );
        testFormats(
          name: "1d 0h 1m 1s",
          duration: const Duration(days: 1, minutes: 1, seconds: 1),
          absolute: "1:00:01:01",
          compact: "1d",
          extended: "1d 1m",
        );
        testFormats(
          name: "1d 1h 0m 0s",
          duration: const Duration(days: 1, hours: 1),
          absolute: "1:01:00:00",
          compact: "1d",
          extended: "1d 1h",
        );
        testFormats(
          name: "1d 1h 0m 1s",
          duration: const Duration(days: 1, hours: 1, seconds: 1),
          absolute: "1:01:00:01",
          compact: "1d",
          extended: "1d 1h 1s",
        );
        testFormats(
          name: "1d 1h 1m 0s",
          duration: const Duration(days: 1, hours: 1, minutes: 1),
          absolute: "1:01:01:00",
          compact: "1d",
          extended: "1d 1h 1m",
        );
        testFormats(
          name: "1d 1h 1m 1s",
          duration: const Duration(days: 1, hours: 1, minutes: 1, seconds: 1),
          absolute: "1:01:01:01",
          compact: "1d",
          extended: "1d 1h 1m",
        );
      });

      group('--negative', () {
        testFormats(
          name: "-0s",
          duration: -const Duration(),
          absolute: "0:00:00:00",
          compact: "0s",
          extended: "0s",
        );
        testFormats(
          name: "-1s",
          duration: -const Duration(seconds: 1),
          absolute: "-0:00:00:01",
          compact: "-1s",
          extended: "-1s",
        );
        testFormats(
          name: "-1m 0s",
          duration: -const Duration(minutes: 1),
          absolute: "-0:00:01:00",
          compact: "-1m",
          extended: "-1m",
        );
        testFormats(
          name: "-1m 1s",
          duration: -const Duration(minutes: 1, seconds: 1),
          absolute: "-0:00:01:01",
          compact: "-1m",
          extended: "-1m 1s",
        );
        testFormats(
          name: "-1h 0m 0s",
          duration: -const Duration(hours: 1),
          absolute: "-0:01:00:00",
          compact: "-1h",
          extended: "-1h",
        );
        testFormats(
          name: "-1h 0m 1s",
          duration: -const Duration(hours: 1, seconds: 1),
          absolute: "-0:01:00:01",
          compact: "-1h",
          extended: "-1h 1s",
        );
        testFormats(
          name: "-1h 1m",
          duration: -const Duration(hours: 1, minutes: 1),
          absolute: "-0:01:01:00",
          compact: "-1h",
          extended: "-1h 1m",
        );
        testFormats(
          name: "-1h 1m 1s",
          duration: -const Duration(hours: 1, minutes: 1, seconds: 1),
          absolute: "-0:01:01:01",
          compact: "-1h",
          extended: "-1h 1m",
        );
        testFormats(
          name: "-1d 0h 0m 0s",
          duration: -const Duration(days: 1),
          absolute: "-1:00:00:00",
          compact: "-1d",
          extended: "-1d",
        );
        testFormats(
          name: "-1d 0h 0m 1s",
          duration: -const Duration(days: 1, seconds: 1),
          absolute: "-1:00:00:01",
          compact: "-1d",
          extended: "-1d 1s",
        );
        testFormats(
          name: "-1d 0h 1m 0s",
          duration: -const Duration(days: 1, minutes: 1),
          absolute: "-1:00:01:00",
          compact: "-1d",
          extended: "-1d 1m",
        );
        testFormats(
          name: "-1d 0h 1m 1s",
          duration: -const Duration(days: 1, minutes: 1, seconds: 1),
          absolute: "-1:00:01:01",
          compact: "-1d",
          extended: "-1d 1m",
        );
        testFormats(
          name: "-1d 1h 0m 0s",
          duration: -const Duration(days: 1, hours: 1),
          absolute: "-1:01:00:00",
          compact: "-1d",
          extended: "-1d 1h",
        );
        testFormats(
          name: "-1d 1h 0m 1s",
          duration: -const Duration(days: 1, hours: 1, seconds: 1),
          absolute: "-1:01:00:01",
          compact: "-1d",
          extended: "-1d 1h 1s",
        );
        testFormats(
          name: "-1d 1h 1m 0s",
          duration: -const Duration(days: 1, hours: 1, minutes: 1),
          absolute: "-1:01:01:00",
          compact: "-1d",
          extended: "-1d 1h 1m",
        );
        testFormats(
          name: "-1d 1h 1m 1s",
          duration: -const Duration(days: 1, hours: 1, minutes: 1, seconds: 1),
          absolute: "-1:01:01:01",
          compact: "-1d",
          extended: "-1d 1h 1m",
        );
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

    group('Duration.remainder {extention}', () {
      const duration = Duration(days: 1, minutes: 3, seconds: 3);

      test('0 modulo', () {
        expect(duration.remainder(Duration.zero), duration);
      });

      test('no modulo', () {
        expect(duration.remainder(const Duration(days: 2)), duration);
      });

      test('1 modulo', () {
        expect(
          duration.remainder(const Duration(days: 1)),
          duration - const Duration(days: 1),
        );
      });
      test('deep modulo', () {
        expect(
          duration.remainder(const Duration(minutes: 1)),
          const Duration(seconds: 3),
        );
      });
    });
  });
}
