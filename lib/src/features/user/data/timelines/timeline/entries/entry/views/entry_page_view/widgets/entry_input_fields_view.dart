import 'package:flutter/material.dart';
import 'package:lifeline/src/widgets/helper/widget_list_extension.dart';
import '../../../input_fields/core/input_field_model.dart';
import '../../../utils/input_field_builder.dart';

class EntryInputFieldsView extends StatefulWidget {
  static const _itemGap = 15.0;

  final List<InputFieldModel> inputFields;
  final void Function() onUpdate;

  const EntryInputFieldsView({
    super.key,
    required this.inputFields,
    required this.onUpdate,
  });

  @override
  State<EntryInputFieldsView> createState() => _EntryInputFieldsViewState();
}

class _EntryInputFieldsViewState extends State<EntryInputFieldsView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final inputField in widget.inputFields)
          InputFieldBuilder.buildWidget(
            model: inputField,
            onChange: (snapshot) {
              final index = widget.inputFields.indexOf(inputField);
              if (inputField.value == snapshot.value || index == -1) return;
              setState(() {
                widget.inputFields[index] = snapshot;
                widget.onUpdate();
              });
            },
          )
      ].withSpaceBetween(height: EntryInputFieldsView._itemGap),
    );
  }
}
