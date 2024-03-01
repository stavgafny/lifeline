import 'package:flutter/material.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/text_input_field/text_input_field_model.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/text_input_field/text_input_field_widget.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TextInputFieldModel(value: "asd");

    return Scaffold(
      body: Center(
        child: TextInputFieldWidget(model: model, onChange: print),
      ),
    );
  }
}
