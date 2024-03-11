import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifeline/src/widgets/dialogs/name_edit_dialog.dart';
import '../../../controllers/goal_tracker_controller.dart';
import './helper/selected_wrapper.dart';

class GoalName extends ConsumerWidget {
  final GoalTrackerProvider provider;
  const GoalName({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(provider.select((model) => model.name));

    return SelectedWrapper(
      provider: provider,
      builder: (context, isSelected) {
        return Flexible(
          child: GestureDetector(
            onTap: () {
              if (isSelected) {
                showDialog(
                  context: context,
                  builder: (context) => NameEditDialog(
                    name: name,
                    onCancel: () => context.pop(),
                    onConfirm: (modifiedName) {
                      ref.read(provider.notifier).setName(modifiedName);
                      context.pop();
                    },
                  ),
                );
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              padding: EdgeInsets.symmetric(horizontal: isSelected ? 6.0 : 0.0),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.onSecondary.withAlpha(75)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSelected)
                    const Padding(
                      padding: EdgeInsets.only(right: 6.0),
                      child: Icon(Icons.label_outline, size: 24.0),
                    ),
                  Flexible(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
