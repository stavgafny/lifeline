import '../core/input_field_model.dart';

class WeightInputFieldModel extends MeasurableInputFieldModel<num> {
  const WeightInputFieldModel({
    required super.value,
  }) : super(type: InputFieldModelType.weight);

  const WeightInputFieldModel.empty()
      : super(type: InputFieldModelType.weight, value: 0);

  @override
  double get measurableValue => value.toDouble();

  @override
  serialize() => value;

  factory WeightInputFieldModel.deserialize(num data) {
    return WeightInputFieldModel(value: data);
  }
}
