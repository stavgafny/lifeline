import 'package:flutter/material.dart';
import '../../models/entry_model.dart';
import '../../utils/input_field_builder.dart';

class EntryPageView extends StatelessWidget {
  final EntryModel model;

  const EntryPageView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final inputFieldModel in model.inputFields)
          InputFieldBuilder.build(
            model: inputFieldModel,
            onChange: (snapshot) {},
          )
      ],
    );
  }
}
