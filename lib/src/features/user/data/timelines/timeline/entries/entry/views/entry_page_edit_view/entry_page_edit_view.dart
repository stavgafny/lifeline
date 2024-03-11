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
    required String title,
    required void Function(EntryModel updatedEntry) onUpdate,
  }) {
    final page = EntryPageEditView._(
      entry: entry,
      title: title,
      onUpdate: onUpdate,
    );

    showDialog(
      context: context,
      builder: (context) => page,
      barrierDismissible: false,
      useSafeArea: false,
    );
  }

  final EntryModel entry;
  final String title;
  final void Function(EntryModel updatedEntry) onUpdate;

  const EntryPageEditView._({
    required this.entry,
    required this.title,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: _padding,
        child: ListView(
          children: [
            for (final inputField in entry.inputFields)
              InputFieldBuilder.buildWidget(
                model: inputField,
                onChange: (snapshot) {
                  if (inputField.value == snapshot.value) return;
                  final index = entry.inputFields.indexOf(inputField);
                  final updatedInputFields = [...entry.inputFields];
                  updatedInputFields[index] = snapshot;
                  onUpdate(entry.copyWith(inputFields: updatedInputFields));
                },
              )
          ].withSpaceBetween(height: _itemGap),
        ),
      ),
    );
  }
}
