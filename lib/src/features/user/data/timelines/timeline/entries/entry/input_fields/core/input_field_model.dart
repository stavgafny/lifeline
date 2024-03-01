import 'dart:convert';

import '../text_input_field/text_input_field_model.dart';

enum InputFieldModelType { text }

abstract class InputFieldModel<T> {
  final InputFieldModelType type;
  final T value;

  const InputFieldModel({required this.type, required this.value});

  dynamic serialize();

  Map<String, dynamic> toMap() => {'type': type.name, 'value': serialize()};

  static InputFieldModel fromMap(Map<String, dynamic> map) {
    final type = InputFieldModelType.values.byName(map['type']);

    switch (type) {
      case InputFieldModelType.text:
        return TextInputFieldModel.deserialize(map['value']);
    }
  }

  String toJson() => json.encode(toMap());

  static fromJson(String source) =>
      InputFieldModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'InputFieldModel[${type.name}](value: $value)';
}

abstract class MeasurableInputFieldModel<T> extends InputFieldModel<T> {
  const MeasurableInputFieldModel({required super.type, required super.value});

  double get measurableValue;

  @override
  String toString() => 'MeasurableInputFieldModel[${type.name}](value: $value)';
}
