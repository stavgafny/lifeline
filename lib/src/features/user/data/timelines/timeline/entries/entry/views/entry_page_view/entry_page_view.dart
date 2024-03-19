import 'package:flutter/material.dart';
import '../../models/entry_model.dart';
import './widgets/entry_input_fields_view.dart';
import './widgets/entry_delete_action.dart';

class EntryPageView extends StatelessWidget {
  static const _padding = EdgeInsets.all(10.0);

  static Future<void> display(
    BuildContext context, {
    required EntryModel entry,
    required String title,
    required void Function() onUpdate,
    required void Function() onDelete,
  }) {
    final page = EntryPageView._(
      entry: entry,
      title: title,
      onUpdate: onUpdate,
      onDelete: onDelete,
    );

    return showDialog(
      context: context,
      builder: (context) => page,
      barrierDismissible: false,
      useSafeArea: false,
    );
  }

  final EntryModel entry;
  final String title;
  final void Function() onUpdate;
  final void Function() onDelete;

  const EntryPageView._({
    required this.entry,
    required this.title,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        actions: [EntryDeleteAction(onDelete: onDelete)],
      ),
      body: Padding(
        padding: EntryPageView._padding,
        child: EntryInputFieldsView(
          inputFields: entry.inputFields,
          onUpdate: onUpdate,
        ),
      ),
    );
  }
}
