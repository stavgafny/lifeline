import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/number_input_field/number_input_field_widget.dart';
import 'package:lifeline/src/features/user/data/timelines/timeline/entries/entry/input_fields/weight_input_field/weight_input_field_widget.dart';
import 'package:lifeline/src/widgets/helper/widget_list_extension.dart';
import '../input_fields/core/input_field_widget.dart';

class EntryLayoutBuilder {
  static const _itemGap = 15.0;

  final BuildContext context;

  const EntryLayoutBuilder.of(this.context);

  Widget buildLayout({required List<InputFieldWidget> inputFieldsWidgets}) {
    final size = MediaQuery.of(context).size;

    final widgets = <Widget>[...inputFieldsWidgets];
    if (size.width > 250.0) {
      _replace(
        widgets,
        [NumberInputFieldWidget, WeightInputFieldWidget],
        (widgets) => Row(
          children: [
            Expanded(child: widgets[0]),
            const SizedBox(width: 8.0),
            Expanded(child: widgets[1]),
          ],
        ),
      );
    }
    return ListView(children: widgets.withSpaceBetween(height: _itemGap));
  }
}

void _replace(
  List<Widget> widgets,
  List<Type> types,
  Widget Function(List<Widget> widgets) replacement,
) {
  final widgetsTypes = widgets.map((e) => e.runtimeType).toList();

  List<int> typesIndex = [];
  for (final type in types) {
    final index = widgetsTypes.indexOf(type);
    if (index == -1) return;
    typesIndex.add(index);
  }

  typesIndex.sort((a, b) => b - a);
  final replacementWidgets = <Widget>[];
  for (final index in typesIndex) {
    replacementWidgets.add(widgets.removeAt(index));
  }
  widgets.insert(typesIndex.last, replacement(replacementWidgets));
}
