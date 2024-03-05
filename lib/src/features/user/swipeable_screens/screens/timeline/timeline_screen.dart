import 'package:flutter/material.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/image_input_field/image_input_field_model.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/text_input_field/text_input_field_model.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/weight_input_field/weight_input_field_model.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/models/entry_model.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/views/entry_page_view/entry_page_view.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const model = EntryModel(
      inputFields: [
        TextInputFieldModel(value: ""),
        ImageInputFieldModel(value: ""),
        WeightInputFieldModel(value: 2),
      ],
      tags: [],
    );

    return const EntryPageView(model: model);
  }
}
