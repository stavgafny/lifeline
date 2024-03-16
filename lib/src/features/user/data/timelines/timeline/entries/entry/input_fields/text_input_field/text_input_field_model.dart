import '../core/input_field_model.dart';

class TextInputFieldModel extends InputFieldModel<String> {
  const TextInputFieldModel({
    required super.value,
  }) : super(type: InputFieldModelType.text);

  const TextInputFieldModel.empty()
      : super(type: InputFieldModelType.text, value: "");

  @override
  String serialize() => value;

  factory TextInputFieldModel.deserialize(String data) {
    return TextInputFieldModel(value: data);
  }
}
