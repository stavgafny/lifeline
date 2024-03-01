import '../core/input_field_model.dart';

class TextInputFieldModel extends InputFieldModel<String> {
  TextInputFieldModel({
    super.type = InputFieldModelType.text,
    required super.value,
  });

  @override
  String serialize() => value;

  factory TextInputFieldModel.deserialize(String data) {
    return TextInputFieldModel(value: data);
  }
}
