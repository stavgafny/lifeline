import 'package:flutter/material.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/image_input_field/image_input_field_model.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/image_input_field/image_input_field_widget.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/number_input_field/number_input_field_model.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/number_input_field/number_input_field_widget.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/stars_input_field/stars_input_field_model.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/stars_input_field/stars_input_field_widget.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/text_input_field/text_input_field_model.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/text_input_field/text_input_field_widget.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/weight_input_field/weight_input_field_widget.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/weight_input_field/weight_input_field_model.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const modelT = TextInputFieldModel(value: "asd");
    const modelN = NumberInputFieldModel(value: 17.5);
    const modelW = WeightInputFieldModel(value: 63.4);
    const modelS = StarsInputFieldModel(value: 2.5);
    const modelI = ImageInputFieldModel(
      value:
          "/data/user/0/com.example.lifeline/cache/16cdb0d7-ffb5-4cf4-9a19-845ba64a022c/1000037053.png",
    );

    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextInputFieldWidget(model: modelT, onChange: print),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NumberInputFieldWidget(model: modelN, onChange: print),
                WeightInputFieldWidget(model: modelW, onChange: print),
              ],
            ),
            SizedBox(height: 10.0),
            StarsInputFieldWidget(model: modelS, onChange: print),
            ImageInputFieldWidget(model: modelI, onChange: print),
          ],
        ),
      ),
    );
  }
}
