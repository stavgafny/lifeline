import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/input_field_widget.dart';
import './number_input_field_model.dart';

class NumberInputFieldWidget extends InputFieldWidget<NumberInputFieldModel> {
  static const _textStyle = TextStyle(fontSize: 20.0);

  static final List<TextInputFormatter> _inputFormatters = <TextInputFormatter>[
    FilteringTextInputFormatter.singleLineFormatter,
    LengthLimitingTextInputFormatter(10),
    FilteringTextInputFormatter.allow(RegExp(r'\d+\.?\d*')),
    for (int i = 0; i < 10; i++)
      FilteringTextInputFormatter.deny(RegExp('^0$i'), replacementString: '$i'),
  ];

  const NumberInputFieldWidget({
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
    return TextFormField(
      initialValue: model.value == 0 ? "" : model.value.toString(),
      inputFormatters: _inputFormatters,
      onChanged: (value) {
        onChange(NumberInputFieldModel(value: num.tryParse(value) ?? 0.0));
      },
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        hintText: "0.0",
        labelText: "Number Field",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      style: _textStyle,
    );
  }
}
