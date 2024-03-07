import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/image_input_field/image_input_field_model.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/number_input_field/number_input_field_model.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/stars_input_field/stars_input_field_model.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/text_input_field/text_input_field_model.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/weight_input_field/weight_input_field_model.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/models/entry_model.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/views/entry_card_view/entry_card_view.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/views/entry_page_view/entry_page_view.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const model = EntryModel(
      inputFields: [
        ImageInputFieldModel(
            value:
                "/data/user/0/com.example.lifeline/files/images/timelines//1000037299.jpg"),
        WeightInputFieldModel(value: 2),
        NumberInputFieldModel(value: 3.512),
        StarsInputFieldModel(value: 3.5),
        TextInputFieldModel(value: ""),
      ],
      tags: [],
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const EntryPageView(model: model);
                },
              ),
            );
          },
          child: const SizedBox(
            width: double.infinity,
            height: 150,
            child: EntryCardView(model: model),
          ),
        ),
      ),
    );
  }
}
