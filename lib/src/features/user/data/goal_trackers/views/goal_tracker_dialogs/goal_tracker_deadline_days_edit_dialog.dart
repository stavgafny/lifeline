import 'package:flutter/material.dart';
import 'package:lifeline/src/widgets/dialogs/number_picker_dialog.dart';

class GoalTrackerDeadlineDaysEditDialog extends StatelessWidget {
  static const int daysRange = 365;

  final int initialDays;
  final void Function() onCancel;
  final void Function(int days) onConfirm;

  const GoalTrackerDeadlineDaysEditDialog({
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
      range: daysRange,
      builder: (index) => "${index + 1}",
      onCancel: onCancel,
      onConfirm: onConfirm,
    );
  }
}
