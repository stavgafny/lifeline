import '../core/input_field_model.dart';

/// Using value type as `num` which can cause innacuracy due to floating points
class NumberInputFieldModel extends MeasurableInputFieldModel<num> {
  const NumberInputFieldModel({
    required super.value,
  }) : super(type: InputFieldModelType.number);

  @override
  double get measurableValue => value.toDouble();

  @override
  serialize() => value;

  factory NumberInputFieldModel.deserialize(num data) {
    return NumberInputFieldModel(value: data);
  }
}
