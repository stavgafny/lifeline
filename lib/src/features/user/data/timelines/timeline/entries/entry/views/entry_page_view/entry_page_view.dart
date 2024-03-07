import 'package:flutter/material.dart';
import 'package:lifeline/src/widgets/helper/widget_list_extension.dart';
import '../../models/entry_model.dart';
import '../../utils/input_field_builder.dart';

class EntryPageView extends StatelessWidget {
  static const _padding = EdgeInsets.all(10.0);
  static const _itemGap = 15.0;

  final EntryModel model;

  const EntryPageView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _padding,
      child: ListView(
        children: [
          for (final inputFieldModel in model.inputFields)
            InputFieldBuilder.buildWidget(
              model: inputFieldModel,
              onChange: (snapshot) {},
            )
        ].withSpaceBetween(height: _itemGap),
      ),
    );
  }
}
