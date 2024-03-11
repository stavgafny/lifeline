import 'package:flutter/material.dart';
import '../../input_fields/core/input_field_model.dart';
import '../../models/entry_model.dart';
import '../../utils/input_field_builder.dart';

class EntryCardView extends StatelessWidget {
  final EntryModel model;
  final void Function()? onTap;

  const EntryCardView({super.key, required this.model, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: _buildPreview(context),
      ),
    );
  }

  Widget _buildPreview(BuildContext context) {
    if (model.inputFields.isEmpty) return const SizedBox();

    final image = model.inputFields
        .where((inputField) => inputField.type == InputFieldModelType.image)
        .firstOrNull;

    final previewInputFields = model.inputFields
        .where((inputField) => inputField.type != InputFieldModelType.image)
        .toList();

    final previewSection = Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (final inputField in previewInputFields)
          InputFieldBuilder.buildPreview(model: inputField)
      ],
    );

    if (image == null) {
      return previewSection;
    }

    return Row(
      children: [
        InputFieldBuilder.buildPreview(model: image),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: previewSection,
          ),
        )
      ],
    );
  }
}
