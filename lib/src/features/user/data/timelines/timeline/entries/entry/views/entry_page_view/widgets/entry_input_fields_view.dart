import 'package:flutter/material.dart';
import '../../../input_fields/core/input_field_model.dart';
import '../../../utils/entry_layout_builder.dart';
import '../../../utils/input_field_builder.dart';

class EntryInputFieldsView extends StatelessWidget {
  final List<InputFieldModel> inputFields;
  final void Function() onUpdate;

  const EntryInputFieldsView({
    super.key,
    required this.inputFields,
    required this.onUpdate,
  });

  void _updateInputField(int index, InputFieldModel updatedInputField) {
    inputFields[index] = updatedInputField;
    onUpdate.call();
  }

  @override
  Widget build(BuildContext context) {
    return EntryLayoutBuilder.of(context).buildLayout(
      inputFieldsWidgets: [
        for (int i = 0; i < inputFields.length; i++)
          InputFieldBuilder.buildWidget(
            model: inputFields[i],
            onChange: (snapshot) => _updateInputField(i, snapshot),
          )
      ],
    );
  }
}
