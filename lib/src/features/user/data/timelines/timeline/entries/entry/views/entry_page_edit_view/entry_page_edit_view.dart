import 'package:flutter/material.dart';
import 'package:lifeline/src/widgets/helper/widget_list_extension.dart';
import '../../models/entry_model.dart';
import '../../utils/input_field_builder.dart';

class EntryPageEditView extends StatefulWidget {
  static const _padding = EdgeInsets.all(10.0);
  static const _itemGap = 15.0;

  static void display(
    BuildContext context, {
    required EntryModel entry,
    required String title,
    required void Function() onUpdate,
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
  final void Function() onUpdate;

  const EntryPageEditView._({
    required this.entry,
    required this.title,
    required this.onUpdate,
  });

  @override
  State<EntryPageEditView> createState() => _EntryPageEditViewState();
}

class _EntryPageEditViewState extends State<EntryPageEditView> {
  @override
  Widget build(BuildContext context) {
    final inputFields = widget.entry.inputFields;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EntryPageEditView._padding,
        child: ListView(
          children: [
            for (final inputField in inputFields)
              InputFieldBuilder.buildWidget(
                model: inputField,
                onChange: (snapshot) {
                  final index = inputFields.indexOf(inputField);
                  if (inputField.value == snapshot.value || index == -1) return;
                  setState(() {
                    widget.entry.inputFields[index] = snapshot;
                    widget.onUpdate();
                  });
                },
              )
          ].withSpaceBetween(height: EntryPageEditView._itemGap),
        ),
      ),
    );
  }
}
