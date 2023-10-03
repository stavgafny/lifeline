import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../controllers/goal_tracker_select_controller.dart';

class ExpandButton extends ConsumerWidget {
  final GoalTrackerProvider provider;

  const ExpandButton({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only watch current selected to remove unnecessary rebuilds on rest

    if (ref.read(goalTrackerSelectProvider.notifier).isSelected(provider)) {
      ref.watch(goalTrackerSelectProvider);
    }
    return GestureDetector(
      onTap: () {
        ref.watch(goalTrackerSelectProvider);
        ref.read(goalTrackerSelectProvider.notifier).select(provider);
      },
      child: Icon(
        ref.read(goalTrackerSelectProvider.notifier).isSelected(provider)
            ? Icons.expand_less
            : Icons.expand_more,
      ),
    );
  }
}
