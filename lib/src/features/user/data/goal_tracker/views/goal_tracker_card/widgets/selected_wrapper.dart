import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../controllers/goal_tracker_select_controller.dart';

// Rebuilds only on selection changes that involve provider.
class SelectedWrapper extends ConsumerWidget {
  final GoalTrackerProvider provider;

  final Widget Function(BuildContext context, bool isSelected) builder;

  const SelectedWrapper({
    super.key,
    required this.provider,
    required this.builder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(goalTrackerSelectProvider.select((p) => p == provider));
    final isSelected =
        ref.read(goalTrackerSelectProvider.notifier).isSelected(provider);

    return builder(context, isSelected);
  }
}
