import '../core/input_field_model.dart';

class StarsInputFieldModel extends MeasurableInputFieldModel<double> {
  static const double minRating = 0;
  static const double maxRating = 5;

  const StarsInputFieldModel({
    required super.value,
  }) : super(type: InputFieldModelType.stars);

  const StarsInputFieldModel.empty()
      : super(type: InputFieldModelType.stars, value: 0);

  @override
  double get measurableValue => value;

  @override
  serialize() => value;

  factory StarsInputFieldModel.deserialize(double data) {
    return StarsInputFieldModel(value: data);
  }
}
