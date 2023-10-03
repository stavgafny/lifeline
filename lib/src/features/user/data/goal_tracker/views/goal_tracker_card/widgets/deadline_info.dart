import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/goal_tracker_controller.dart';
import '../../../utils/goal_tracker_info_formatter.dart';

class DeadlineInfo extends ConsumerWidget {
  final GoalTrackerProvider provider;
  const DeadlineInfo({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deadlineInfo = ref.watch(
      provider.select(GoalTrackerInfoFormatter.deadlineRemainingTime),
    );
    return Text(
      deadlineInfo,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
