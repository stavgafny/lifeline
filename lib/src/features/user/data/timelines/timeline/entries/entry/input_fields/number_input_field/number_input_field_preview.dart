import 'package:flutter/material.dart';
import '../core/input_field_preview.dart';
import './number_input_field_model.dart';

class NumberInputFieldPreview extends InputFieldPreview<NumberInputFieldModel> {
  static const _textStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  const NumberInputFieldPreview({super.key, required super.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Number:", style: _textStyle),
        const SizedBox(width: 4.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary.withAlpha(75),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text("${model.value}", style: _textStyle),
        ),
      ],
    );
  }
}
