import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/upcoming_event_controller.dart';
import '../../upcoming_event_dialogs/upcoming_event_type_edit_dialog.dart';

class TypeEdit extends ConsumerWidget {
  final UpcomingEventProvider editProvider;

  const TypeEdit({super.key, required this.editProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = ref.watch(editProvider.select((model) => model.type));

    return AspectRatio(
      aspectRatio: 1.75,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          image: DecorationImage(
            fit: BoxFit.contain,
            image: type.value,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => UpcomingEventTypeEditDialog(
                  onSubmit: (type) {
                    ref.read(editProvider.notifier).setType(type: type);
                    Navigator.of(context).pop();
                  },
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
