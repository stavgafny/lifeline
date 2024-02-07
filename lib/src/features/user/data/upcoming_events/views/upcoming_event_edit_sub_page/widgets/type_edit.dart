import 'package:flutter/material.dart';
import '../../../models/upcoming_event_model.dart';
import '../../upcoming_event_dialogs/upcoming_event_type_edit_dialog.dart';

class TypeEdit extends StatelessWidget {
  final UpcomingEventModel model;

  const TypeEdit({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.75,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          image: DecorationImage(
            fit: BoxFit.contain,
            image: model.type.value,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => UpcomingEventTypeEditDialog(
                  onSubmit: (type) {},
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ),
      ),
    );
  }
}
