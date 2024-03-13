import 'package:flutter/material.dart';
import 'package:wheel_picker/wheel_picker.dart';
import './core/dialog_action_buttons_builder.dart';

class NumberPickerDialog extends StatefulWidget {
  final String? title;
  final int initialNumber;
  final int range;
  final String Function(int index) builder;
  final void Function() onCancel;
  final void Function(int days) onConfirm;

  const NumberPickerDialog({
    super.key,
    this.title,
    this.initialNumber = 0,
    required this.range,
    required this.builder,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  State<NumberPickerDialog> createState() => _NumberPickerDialogState();
}

class _NumberPickerDialogState extends State<NumberPickerDialog> {
  static const _labelTextStyle = TextStyle(fontSize: 16.0);
  static const _wheelTextStyle = TextStyle(fontSize: 20.0, height: 2.5);
  final _wheelStyle = WheelPickerStyle(
    itemExtent: _wheelTextStyle.fontSize! * _wheelTextStyle.height!,
    size: 150.0,
    squeeze: 1.5,
    diameterRatio: .8,
    surroundingOpacity: .25,
    magnification: 1.25,
  );

  late final _controller = WheelPickerController(
    itemCount: widget.range,
    initialIndex: widget.initialNumber,
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(60.0),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.title ?? "", style: _labelTextStyle),
              WheelPicker(
                builder: (context, index) {
                  return Text(widget.builder(index), style: _wheelTextStyle);
                },
                controller: _controller,
                style: _wheelStyle,
                looping: false,
              ),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DialogActionButtonsBuilder.buildMaterialAction(
          text: "Cancel",
          onAction: widget.onCancel,
        ),
        DialogActionButtonsBuilder.buildMaterialAction(
          text: "OK",
          onAction: () => widget.onConfirm(_controller.selected + 1),
        ),
      ],
    );
  }
}
