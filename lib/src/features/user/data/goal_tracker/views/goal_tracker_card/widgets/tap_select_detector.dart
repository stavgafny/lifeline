import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../controllers/goal_tracker_select_controller.dart';

class TapSelectDetector extends ConsumerWidget {
  final GoalTrackerProvider provider;
  final Widget child;

  const TapSelectDetector({
    super.key,
    required this.provider,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ref.read(goalTrackerSelectProvider.notifier).select(provider);
      },
      child: child,
    );
  }
}
