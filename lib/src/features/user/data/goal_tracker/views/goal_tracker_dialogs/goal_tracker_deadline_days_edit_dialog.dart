import 'package:flutter/material.dart';
import 'package:wheel_picker/wheel_picker.dart';

class GoalTrackerDeadlineDaysEditDialog extends StatefulWidget {
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
  State<GoalTrackerDeadlineDaysEditDialog> createState() =>
      _GoalTrackerDeadlineDaysEditDialogState();
}

class _GoalTrackerDeadlineDaysEditDialogState
    extends State<GoalTrackerDeadlineDaysEditDialog> {
  static const _labelTextStyle = TextStyle(fontSize: 14.0);
  static const _wheelTextStyle = TextStyle(fontSize: 22.0, height: 1.2);
  static const _buttonsTextStyle = TextStyle(fontSize: 18.0);
  final _wheelStyle = WheelPickerStyle(
    itemExtent: _wheelTextStyle.fontSize! * _wheelTextStyle.height!,
    size: 150.0,
    squeeze: 1.15,
    diameterRatio: .85,
    surroundingOpacity: .25,
    magnification: 1.25,
  );

  late final _controller = WheelPickerController(
    itemCount: 365,
    initialIndex: widget.initialDays - 1,
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(40.0),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WheelPicker(
                builder: (context, index) {
                  return Text("${index + 1}", style: _labelTextStyle);
                },
                controller: _controller,
                style: _wheelStyle,
                looping: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    onPressed: widget.onCancel,
                    textColor: Theme.of(context).colorScheme.primary,
                    child: const Text("Cancel", style: _buttonsTextStyle),
                  ),
                  MaterialButton(
                    onPressed: () => widget.onConfirm(_controller.selected + 1),
                    textColor: Theme.of(context).colorScheme.primary,
                    child: const Text("OK", style: _buttonsTextStyle),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
