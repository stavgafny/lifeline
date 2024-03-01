import 'package:flutter/material.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/number_input_field/number_input_field_model.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/number_input_field/number_input_field_widget.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/text_input_field/text_input_field_model.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/text_input_field/text_input_field_widget.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const modelT = TextInputFieldModel(value: "asd");
    const modelN = NumberInputFieldModel(value: 17.5);

    return const Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextInputFieldWidget(model: modelT, onChange: print),
              NumberInputFieldWidget(model: modelN, onChange: print)
            ],
          ),
        ),
      ),
    );
  }
}
