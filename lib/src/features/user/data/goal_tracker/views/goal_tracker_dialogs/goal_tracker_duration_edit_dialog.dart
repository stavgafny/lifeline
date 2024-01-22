import 'package:flutter/material.dart';
import 'package:wheel_picker/wheel_picker.dart';

class GoalTrackerDurationEditDialog extends StatefulWidget {
  final Duration initialDuration;
  final void Function() onCancel;
  final void Function(Duration duration) onConfirm;

  const GoalTrackerDurationEditDialog({
    super.key,
    required this.initialDuration,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  State<GoalTrackerDurationEditDialog> createState() =>
      _GoalTrackerDurationEditDialogState();
}

class _GoalTrackerDurationEditDialogState
    extends State<GoalTrackerDurationEditDialog> {
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

  late final _daysController = WheelPickerController(
    itemCount: 100,
    initialIndex: widget.initialDuration.inDays,
  );
  late final _hoursController = WheelPickerController(
    itemCount: Duration.hoursPerDay,
    mounts: [_daysController],
    initialIndex: widget.initialDuration.inHours.remainder(
      Duration.hoursPerDay,
    ),
  );
  late final _minutesController = WheelPickerController(
    itemCount: Duration.minutesPerHour,
    mounts: [_hoursController],
    initialIndex: widget.initialDuration.inMinutes.remainder(
      Duration.minutesPerHour,
    ),
  );

  Widget _buildTimeUnitWheel({
    required String label,
    required WheelPickerController controller,
  }) {
    final isDays = controller == _daysController;
    return Column(
      children: [
        Text(label, style: _labelTextStyle),
        WheelPicker(
          builder: isDays
              ? (c, i) => Text("$i", style: _wheelTextStyle)
              : (c, i) => Text("$i".padLeft(2, '0'), style: _wheelTextStyle),
          controller: controller,
          style: _wheelStyle,
          looping: !isDays,
        ),
      ],
    );
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTimeUnitWheel(
                      label: "Days", controller: _daysController),
                  _buildTimeUnitWheel(
                      label: "Hours", controller: _hoursController),
                  _buildTimeUnitWheel(
                      label: "Minutes", controller: _minutesController),
                ],
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
                    onPressed: () => widget.onConfirm(
                      Duration(
                        days: _daysController.selected,
                        hours: _hoursController.selected,
                        minutes: _minutesController.selected,
                      ),
                    ),
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

  @override
  void dispose() {
    _daysController.dispose();
    _hoursController.dispose();
    _minutesController.dispose();
    super.dispose();
  }
}
