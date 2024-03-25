import './input_field_model.dart';

class InputFieldsScopedModel {
  final InputFieldModel? model;
  final List<InputFieldModel> rest;

  bool get notFound => model == null;

  const InputFieldsScopedModel(this.model, this.rest);
}

final _inputFieldsOrder = <InputFieldModelType>[
  InputFieldModelType.image,
  InputFieldModelType.number,
  InputFieldModelType.weight,
  InputFieldModelType.stars,
  InputFieldModelType.text,
];

extension InputFieldsTypeHelper on List<InputFieldModelType> {
  void sortInputFieldsByOrder() {
    sort((a, b) => _inputFieldsOrder.indexOf(a) - _inputFieldsOrder.indexOf(b));
  }
}

extension InputFieldsHelper on List<InputFieldModel> {
  InputFieldsScopedModel getModelByType(InputFieldModelType type) {
    final index = indexWhere((model) => model.type == type);
    if (index == -1) {
      return InputFieldsScopedModel(null, this);
    }
    return InputFieldsScopedModel(
      this[index],
      [...this]..removeAt(index),
    );
  }
}
