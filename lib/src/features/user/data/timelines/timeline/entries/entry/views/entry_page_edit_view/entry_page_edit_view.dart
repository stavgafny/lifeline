import 'package:flutter/material.dart';
import 'package:lifeline/src/widgets/helper/widget_list_extension.dart';
import '../../models/entry_model.dart';
import '../../utils/input_field_builder.dart';

class EntryPageEditView extends StatelessWidget {
  static const _padding = EdgeInsets.all(10.0);
  static const _itemGap = 15.0;

  static void display(
    BuildContext context, {
    required EntryModel entry,
  }) {
    final page = EntryPageEditView._(entry: entry);

    showDialog(
      context: context,
      builder: (context) => page,
      barrierDismissible: false,
      useSafeArea: false,
    );
  }

  final EntryModel entry;

  const EntryPageEditView._({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text(
          "Entry",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: _padding,
        child: ListView(
          children: [
            for (final inputFieldModel in entry.inputFields)
              InputFieldBuilder.buildWidget(
                model: inputFieldModel,
                onChange: (snapshot) {},
              )
          ].withSpaceBetween(height: _itemGap),
        ),
      ),
    );
  }
}
