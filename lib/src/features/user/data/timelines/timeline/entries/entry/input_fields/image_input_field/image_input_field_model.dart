import '../core/input_field_model.dart';

class ImageInputFieldModel extends InputFieldModel<String> {
  const ImageInputFieldModel({
    required super.value,
  }) : super(type: InputFieldModelType.image);

  const ImageInputFieldModel.empty()
      : super(type: InputFieldModelType.image, value: "");

  @override
  String serialize() => value;

  factory ImageInputFieldModel.deserialize(String data) {
    return ImageInputFieldModel(value: data);
  }
}
