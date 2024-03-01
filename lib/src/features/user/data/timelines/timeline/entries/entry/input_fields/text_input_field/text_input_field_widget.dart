import 'package:flutter/material.dart';
import '../core/input_field_widget.dart';
import './text_input_field_model.dart';

class TextInputFieldWidget extends InputFieldWidget<TextInputFieldModel> {
  const TextInputFieldWidget({
    super.key,
    required super.model,
    required super.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: model.value),
      onChanged: (value) => onChange(TextInputFieldModel(value: value)),
    );
  }
}
