import 'package:flutter/material.dart';
import '../../input_fields/core/input_fields_helper.dart';
import '../../input_fields/core/input_field_model.dart';
import '../../models/entry_model.dart';
import '../../utils/input_field_builder.dart';
import './widgets/entry_index_banner.dart';

class EntryCardView extends StatelessWidget {
  final EntryModel model;
  final int entryIndex;
  final void Function()? onTap;

  const EntryCardView({
    super.key,
    required this.model,
    required this.entryIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: EntryIndexBanner(
          index: entryIndex,
          child: _buildPreview(context),
        ),
      ),
    );
  }

  Widget _buildPreview(BuildContext context) {
    if (model.inputFields.isEmpty) return const SizedBox();

    final imageScope = model.inputFields.getModelByType(
      InputFieldModelType.image,
    );

    final previewSection = SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (final inputField in imageScope.rest)
            InputFieldBuilder.buildPreview(model: inputField)
        ],
      ),
    );

    if (imageScope.notFound) {
      return previewSection;
    }

    return Row(
      children: [
        InputFieldBuilder.buildPreview(model: imageScope.model!),
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
