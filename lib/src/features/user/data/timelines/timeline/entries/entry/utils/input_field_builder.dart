import 'package:flutter/material.dart';

import '../input_fields/core/input_field_model.dart';
import '../input_fields/core/input_field_preview.dart';

import '../input_fields/image_input_field/image_input_field_model.dart';
import '../input_fields/image_input_field/image_input_field_preview.dart';
import '../input_fields/image_input_field/image_input_field_widget.dart';

import '../input_fields/number_input_field/number_input_field_model.dart';
import '../input_fields/number_input_field/number_input_field_preview.dart';
import '../input_fields/number_input_field/number_input_field_widget.dart';

import '../input_fields/stars_input_field/stars_input_field_model.dart';
import '../input_fields/stars_input_field/stars_input_field_preview.dart';
import '../input_fields/stars_input_field/stars_input_field_widget.dart';

import '../input_fields/text_input_field/text_input_field_model.dart';
import '../input_fields/text_input_field/text_input_field_preview.dart';
import '../input_fields/text_input_field/text_input_field_widget.dart';

import '../input_fields/weight_input_field/weight_input_field_model.dart';
import '../input_fields/weight_input_field/weight_input_field_preview.dart';
import '../input_fields/weight_input_field/weight_input_field_widget.dart';

class InputFieldBuilder {
  static InputFieldPreview buildPreview({required InputFieldModel model}) {
    final type = model.type;
    switch (type) {
      case InputFieldModelType.text:
        return TextInputFieldPreview(model: model as TextInputFieldModel);
      case InputFieldModelType.number:
        return NumberInputFieldPreview(model: model as NumberInputFieldModel);
      case InputFieldModelType.weight:
        return WeightInputFieldPreview(model: model as WeightInputFieldModel);
      case InputFieldModelType.stars:
        return StarsInputFieldPreview(model: model as StarsInputFieldModel);
      case InputFieldModelType.image:
        return ImageInputFieldPreview(model: model as ImageInputFieldModel);
    }
  }

  static Widget buildWidget({
    required InputFieldModel model,
    required final void Function(InputFieldModel snapshot) onChange,
  }) {
    final type = model.type;
    switch (type) {
      case InputFieldModelType.text:
        return TextInputFieldWidget(
          model: model as TextInputFieldModel,
          onChange: onChange,
        );
      case InputFieldModelType.number:
        return NumberInputFieldWidget(
          model: model as NumberInputFieldModel,
          onChange: onChange,
        );
      case InputFieldModelType.weight:
        return WeightInputFieldWidget(
          model: model as WeightInputFieldModel,
          onChange: onChange,
        );
      case InputFieldModelType.stars:
        return StarsInputFieldWidget(
          model: model as StarsInputFieldModel,
          onChange: onChange,
        );
      case InputFieldModelType.image:
        return ImageInputFieldWidget(
          model: model as ImageInputFieldModel,
          onChange: onChange,
        );
    }
  }
}
