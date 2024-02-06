import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifeline/src/constants/theme/extensions/upcoming_event_edit_page_colors.dart';
import '../../../models/upcoming_event_model.dart';
import '../../../utils/upcoming_event_edit_properties.dart';
import '../../upcoming_event_dialogs/upcoming_event_days_edit_dialog.dart';

class DateDaysTimeEdit extends StatelessWidget {
  final UpcomingEventModel model;

  const DateDaysTimeEdit({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<UpcomingEventEditPageColors>()!;

    return SizedBox(
      height: 100,
      child: Row(
        children: [
          _EditField(
            onTap: () {
              final now = DateTime.now();
              showDatePicker(
                context: context,
                firstDate: now.subtract(UpcomingEventEditProperties.dateRange),
                lastDate: now.add(UpcomingEventEditProperties.dateRange),
                initialDate: now.isAfter(model.datetime) ? now : model.datetime,
              );
            },
            flex: 10,
            color: colors.date!,
            title: "Date",
            body: DateFormat('EE, dd MMM, yyyy').format(model.datetime),
          ),
          _EditField(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return UpcomingEventDaysEditDialog(
                    initialDays: model.daysRemain >= 1 ? model.daysRemain : 1,
                    onCancel: () {},
                    onConfirm: (days) {},
                  );
                },
              );
            },
            flex: 7,
            color: colors.days!,
            title: "Days",
            body: model.daysRemain.toString(),
          ),
          _EditField(
            onTap: () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(model.datetime),
              );
            },
            flex: 6,
            color: colors.time!,
            title: "Time",
            body: DateFormat('HH:mm').format(model.datetime),
          )
        ],
      ),
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
