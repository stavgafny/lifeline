import 'package:flutter/material.dart';
import '../core/input_field_widget.dart';
import './text_input_field_model.dart';

class TextInputFieldWidget extends InputFieldWidget<TextInputFieldModel> {
  static const double _maxHeightFromScreen = .5;

  const TextInputFieldWidget({
    super.key,
    required super.model,
    required super.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface),
      borderRadius: BorderRadius.circular(15.0),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * _maxHeightFromScreen,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: RawScrollbar(
          thumbColor: Theme.of(context).colorScheme.onSurface,
          mainAxisMargin: 10.0,
          thickness: 4.0,
          child: TextFormField(
            initialValue: model.value,
            onChanged: (value) => onChange(
              TextInputFieldModel(value: value),
            ),
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              enabledBorder: inputBorder,
              focusedBorder: inputBorder,
              hintText: "Type your details here...",
              labelText: "Text Field",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
      ),
    );
  }
}
