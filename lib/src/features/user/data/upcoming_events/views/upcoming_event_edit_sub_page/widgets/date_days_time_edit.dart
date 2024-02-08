import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lifeline/src/constants/theme/extensions/upcoming_event_edit_page_colors.dart';
import 'package:lifeline/src/utils/time_helper.dart';
import '../../../controllers/upcoming_event_controller.dart';
import '../../../utils/upcoming_event_edit_properties.dart';
import '../../upcoming_event_dialogs/upcoming_event_days_edit_dialog.dart';

class DateDaysTimeEdit extends StatelessWidget {
  static const _editFieldsHeight = 100.0;

  final UpcomingEventProvider editProvider;

  const DateDaysTimeEdit({super.key, required this.editProvider});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _editFieldsHeight,
      child: Row(
        children: [
          _DateEditField(editProvider: editProvider),
          _DaysEditField(editProvider: editProvider),
          _TimeEditField(editProvider: editProvider),
        ],
      ),
    );
  }
}

class _DateEditField extends ConsumerWidget {
  final UpcomingEventProvider editProvider;

  const _DateEditField({required this.editProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateTime = ref.watch(editProvider.select((model) => model.dateTime));
    return _EditField(
      onTap: () async {
        final now = DateTime.now();
        final DateTime? newDate = await showDatePicker(
          context: context,
          firstDate: now.subtract(UpcomingEventEditProperties.dateRange),
          lastDate: now.add(UpcomingEventEditProperties.dateRange),
          initialDate: now.isAfter(dateTime) ? now : dateTime,
        );
        if (newDate != null) {
          final newDateTime = newDate.withTime(
            time: TimeOfDay.fromDateTime(dateTime),
          );
          ref.read(editProvider.notifier).setDatetime(dateTime: newDateTime);
        }
      },
      flex: 10,
      color: Theme.of(context).extension<UpcomingEventEditPageColors>()!.date!,
      title: "Date",
      body: DateFormat('EE, dd MMM, yyyy').format(dateTime),
    );
  }
}

class _DaysEditField extends ConsumerWidget {
  final UpcomingEventProvider editProvider;

  const _DaysEditField({required this.editProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateTime = ref.watch(editProvider.select((model) => model.dateTime));
    final daysRemain =
        ref.watch(editProvider.select((model) => model.daysRemain));
    return _EditField(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return UpcomingEventDaysEditDialog(
              initialDays: daysRemain >= 1 ? daysRemain : 1,
              onCancel: () {
                Navigator.of(context).pop();
              },
              onConfirm: (days) {
                final now = DateTime.now().add(Duration(days: days)).dateOnly();

                final newDateTime = now.withTime(
                  time: TimeOfDay.fromDateTime(dateTime),
                );
                ref
                    .read(editProvider.notifier)
                    .setDatetime(dateTime: newDateTime);
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
      flex: 7,
      color: Theme.of(context).extension<UpcomingEventEditPageColors>()!.days!,
      title: "Days",
      body: daysRemain.toString(),
    );
  }
}

class _TimeEditField extends ConsumerWidget {
  final UpcomingEventProvider editProvider;

  const _TimeEditField({required this.editProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateTime = ref.watch(editProvider.select((model) => model.dateTime));
    return _EditField(
      onTap: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(dateTime),
        );
        if (time != null) {
          ref
              .read(editProvider.notifier)
              .setDatetime(dateTime: dateTime.withTime(time: time));
        }
      },
      flex: 6,
      color: Theme.of(context).extension<UpcomingEventEditPageColors>()!.time!,
      title: "Time",
      body: DateFormat('HH:mm').format(dateTime),
    );
  }
}

class _EditField extends StatelessWidget {
  final void Function() onTap;
  final int flex;
  final Color color;
  final String title;
  final String body;
  const _EditField({
    required this.onTap,
    required this.flex,
    required this.color,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          color: color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    body,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
