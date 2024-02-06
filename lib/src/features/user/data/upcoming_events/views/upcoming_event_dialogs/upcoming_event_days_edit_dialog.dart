import 'package:flutter/material.dart';
import 'package:lifeline/src/widgets/number_picker_dialog.dart';
import '../../utils/upcoming_event_edit_properties.dart';

class UpcomingEventDaysEditDialog extends StatelessWidget {
  final int initialDays;
  final void Function() onCancel;
  final void Function(int days) onConfirm;

  const UpcomingEventDaysEditDialog({
    super.key,
    required this.initialDays,
    required this.onCancel,
    required this.onConfirm,
  });
  @override
  Widget build(BuildContext context) {
    return NumberPickerDialog(
      title: "Days",
      initialNumber: initialDays - 1,
      range: UpcomingEventEditProperties.dateRange.inDays,
      builder: (index) => "${index + 1}",
      onCancel: onCancel,
      onConfirm: onConfirm,
    );
  }
}
